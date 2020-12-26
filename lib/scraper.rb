require 'httparty'
require 'nokogiri'

class Scraper
attr_accessor :all_jobs

    def initialize
        @vacancies= ['front+end+developer', 'back+end+developer&' ,'full+sack+developer', 'ruby+developer', 'javascript+developer']
        @page_number = ['' , '&start=10', '&start=20', '&start=30', '&start=40' ]
        @posted_days = [1 , 3 , 7 , 14 , 'all']
        @all_jobs = Array.new
    end
    
    def scrapper(job_number, number_of_days , number_of_pages )
        looking_for = @vacancies[job_number-1]
        date_posted = @posted_days [number_of_days-1]
        number = number_of_days
        page_result = @page_number[number_of_pages-1]
        if number == 5
         @url_date = "https://www.indeed.com/jobs?q=#{looking_for}&l=Remote"
        else
         @url_date = "https://www.indeed.com/jobs?q=#{looking_for}&l=Remote&fromage=#{number}#{page_result}"
        end
        page = HTTParty.get(@url_date)
        scrapped_page = Nokogiri::HTML(page.body) #> body  avoid annoying msg in terminal (https://stackoverflow.com/questions/61590268/deprecation-httparty-will-no-longer-override-responsenil-what-does-this-de)
        job_cards = scrapped_page.css('div.jobsearch-SerpJobCard') 
        job_cards.each do |job|
            one_job = {
                title: job.css('a.jobtitle').text,
                company: job.css('span.company').text,
                link: "https://www.indeed.com"+ job.css('a')[0].attributes['href'].value,
                date: job.css('span.date').text
            }
            @all_jobs << one_job
        end
    end
   
    # def find_jobs
    #     @all_jobs.each_with_index do |(key , value) , index |
    #         job_title = @all_jobs[index][:title]
    #         job_company = @all_jobs[index][:company]
    #         job_date = @all_jobs[index][:date]
    #         job_link = @all_jobs[index][:link]  
    #         yield
    #     end
    # end

    def page_result
        @url_date
    end

end

