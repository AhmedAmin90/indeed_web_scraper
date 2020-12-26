require_relative '../lib/scraper'
require 'rainbow'
require 'whirly'
require 'paint'

search = Scraper.new


puts Rainbow("Welcome To The Indeed Web Developer Remote Jobs Scraper!\n").gold
puts Rainbow("How to use this scraper? \n").bold
puts Rainbow("1- Select the job title that you are looking for. \n").red + 
Rainbow("2- Select the desired date posted of the jobs. \n").orange +
Rainbow("3- Select which page result that you like to visit directly. \n").blue +
Rainbow("Then, you will get the list of jobs with their links! \n").green.bold.underline


puts Rainbow("Select the number of the job  you are looking for: ").yellow
puts Rainbow("1- Front-End developer 
2- Back-End developer
3- Full-stack developer
4- Ruby developer
5- Js developer").blue
job_number = gets.chomp.to_i
until [1,2,3,4,5].include?(job_number) == true
    puts Rainbow('please select number from the previous detected numbers').red.bold
    job_number = gets.chomp.to_i
end


puts Rainbow("Select the posted date of the job ").yellow
puts Rainbow("1- last 24 hours
2- last 3 days
3- last 7 days
4- last 14 days
5- All results").blue
number_of_days =  gets.chomp.to_i
until [1,2,3,4,5].include?(number_of_days) == true
    puts Rainbow('please select number from the previous detected numbers').red.bold
    number_of_days = gets.chomp.to_i
end

puts Rainbow("which result page do you like to go?").yellow
puts Rainbow("1- First result page
2- Second result page
3- Third result page
4- Fourth result page
5- Fifth result page").blue
number_of_pages =  gets.chomp.to_i
until [1,2,3,4,5].include?(number_of_pages) == true
    puts Rainbow('please select number from the previous detected numbers').red.bold
    number_of_pages =  gets.chomp.to_i
end

puts 

Whirly.configure(spinner: "dots", stop: "✔")
Whirly.start status: "Processing" do
   

search.scrapper(job_number,number_of_days,number_of_pages)

puts Rainbow("Here we are !\n").gold.bold
search.all_jobs.each_with_index  do |(key , value) , index |
    job_title = Rainbow(search.all_jobs[index][:title]).green
    job_company = Rainbow(search.all_jobs[index][:company]).blue
    job_date = Rainbow(search.all_jobs[index][:date]).green
    job_link = Rainbow(search.all_jobs[index][:link]).yellow 
    puts Rainbow("\nThe job number: #{index + 1}\n").red
    puts Rainbow(
        "The vacancy is:").bold.underline+"#{job_title}\n "
    puts Rainbow(
        "The company is:").bold.underline+"#{job_company}\n "
    puts "The job is posted from #{job_date}"
    puts"The details of the Job is in this link:
#{job_link}\n " 
end

puts search.page_result

end
puts Rainbow("Done").gold.bold