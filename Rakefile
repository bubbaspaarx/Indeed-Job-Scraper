require_relative './scraper'

desc "Scrape indeed"
task :scrape, [:search_term, :pages] do |t, args|
  args.with_defaults(:search_term => "sales", :pages => "0")
  num = args.pages.to_i
  num
    while num >= 0
      scrape_indeed(args)
      num -= 1
    end
end
