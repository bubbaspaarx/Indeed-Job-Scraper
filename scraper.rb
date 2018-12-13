require 'nokogiri'
require 'json'
require 'open-uri'

@filepath = 'jobs.json'
@url = 'https://www.indeed.co.uk/jobs?l=london'

file = File.read(@filepath)
job_hash = JSON.parse(file)
@arr = job_hash["jobs"]

def scrape_indeed(args)
  url_args = @url + "&q=#{args.search_term}" + "&start=#{args.pages*10}"
  puts "Accessing Indeed with search term: #{args.search_term}"
  indeed_raw = open(url_args).read
  indeed_doc = Nokogiri::HTML(indeed_raw)
  puts "Converting raw data"
  strip_doc(indeed_doc)
end

def strip_doc(html_doc)
  puts "Stripping out data"
  html_doc.search('.jobsearch-SerpJobCard').each do |card|
    job = {
      title: card.css('.jobtitle').text.strip,
      company: card.css('.company').text.strip,
      location: card.css('.location').text.strip,
      salary: card.css('.salary.no-wrap').text.strip,
      summary: card.css('.summary').text.strip,
      link: "https://www.indeed.co.uk" + card.css('a').attribute('href').value,
      listing_html: ''
    }
    job[:listing_html] = job_page(job[:link])
    @arr.push(job)
  end
  store_jobs(@arr)
end

def job_page(link)
  job_page_raw = open(link).read
  job_page_doc = Nokogiri::HTML(job_page_raw)
  job_noko = job_page_doc.css('.jobsearch-JobComponent-description')
  job_html = job_noko.to_html.gsub(/\n/, '')
end

def store_jobs(jobs_arr)
  puts "Storing data"
  jobs = {jobs: jobs_arr}
  File.open(@filepath, 'wb') do |file|
    file.write(JSON.pretty_generate(jobs))
  end
  puts "Completed!"
end
