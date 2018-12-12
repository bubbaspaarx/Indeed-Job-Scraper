###Welcome to my Indeed Job Scraper

##Description

This is a scraper for the Indeed.co.uk job site. It's basic function is to search for jobs based on options passed in to a rake task and return a json of those jobs.

The details returned are

- title
- company
- location
- salary
- job summary
- link to job page
- listing_html for reuse

##Instructions to use

```zsh
  rake indeed_scraper
```

or with options to scrape for a particular job type and number of pages to scrape.

```zsh
  rake indeed_scraper[job_type, number_of_pages]
```
