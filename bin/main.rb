require_relative '../lib/scraper'

search = Scraper.new

puts "Select the number of the job  you are looking for: "
puts "1- Front-End developer 
2- Back-End developer
3- Full-stack developer
4- Ruby developer
5- Js developer"
job_number = gets.chomp.to_i
until [1,2,3,4,5].include?(job_number) == true
    puts 'please select number from the previous detected numbers'
    job_number = gets.chomp.to_i
end


puts "Select the posted date of the job "
puts "1- last 24 hours
2- last 3 days
3- last 7 days
4- last 14 days
5- All results"
number_of_days = gets.chomp.to_i
until [1,2,3,4,5].include?(number_of_days) == true
    puts 'please select number from the previous detected numbers'
    number_of_days = gets.chomp.to_i
end

puts "which result page do you like to go?"
puts "1- First result page
2- Second result page
3- Third result page
4- Fourth result page
5- Fifth result page"
number_of_pages = gets.chomp.to_i
until [1,2,3,4,5].include?(number_of_pages) == true
    puts 'please select number from the previous detected numbers'
    number_of_pages = gets.chomp.to_i
end

search.scrapper(job_number,number_of_days,number_of_pages)

search.all_jobs.each_with_index  do |(key , value) , index |
    job_title = search.all_jobs[index][:title]
    job_company = search.all_jobs[index][:company]
    job_date = search.all_jobs[index][:date]
    job_link = search.all_jobs[index][:link]  
    puts "The vaccancy is" + "#{job_title}" + "The company is" + "#{job_company}" + "The job is posted from" + "#{job_date}" +"The details of the Job is in this link:" + "#{job_link}"
end

puts search.page_result