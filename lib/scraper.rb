require 'httparty'
require 'nokogiri'
require 'rainbow'
require 'csv'

class Scraper
  attr_accessor :all_jobs

  def initialize
    @vacancies = ['front+end+developer',
                  'back+end+developer&',
                  'full+sack+developer',
                  'ruby+developer',
                  'javascript+developer']
    @page_number = ['', '&start=10', '&start=20', '&start=30', '&start=40']
    @posted_days = [1, 3, 7, 14, 'all']
    @all_jobs = []
  end

  def scraper(job, days, pages)
    looking_for = @vacancies[job - 1]
    date_posted = @posted_days[days - 1]
    page_result = @page_number[pages - 1]
    @url_date = if days == 5
                  "https://www.indeed.com/jobs?q=#{looking_for}&l=Remote"
                else
                  "https://www.indeed.com/jobs?q=#{looking_for}&l=Remote&fromage=#{date_posted}#{page_result}"
                end
  end

  def make_array
    scrapped_page = Nokogiri::HTML(HTTParty.get(@url_date).body)
    job_cards = scrapped_page.css('div.jobsearch-SerpJobCard')
    job_cards.each do |vacancy|
      one_job = {
        title: vacancy.css('a.jobtitle').text,
        company: vacancy.css('span.company').text,
        link: "https://www.indeed.com#{vacancy.css('a')[0].attributes['href'].value}",
        date: vacancy.css('span.date').text
      }
      all_jobs << one_job
    end
    all_jobs
  end

  def page_result
    Rainbow("\nThe link of the page: \n").bold.underline + Rainbow("#{url_date}\n").purple
  end
end
