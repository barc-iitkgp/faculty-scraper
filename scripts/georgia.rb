require 'csv'
require 'mechanize'

bot = Mechanize.new
bot.follow_meta_refresh = true 
bot.verify_mode = OpenSSL::SSL::VERIFY_NONE

page = bot.get("https://www.ece.gatech.edu/faculty-staff-directory?field_group_filter_value=1")
CSV.open("../data/georgia.csv", "a") do |csv|
  csv << ["NAME","MAIL ID","PAGE","WORK"]
end

num =  page.search(".faculty-staff-information").count 
for i in (0..num-1)
  name = page.search(".faculty-staff-information .field-full-name")[i].text.strip
  email = page.search(".faculty-staff-information .field-email-address")[i].children[1]["href"].gsub("mailto:","")
  work = page.search(".faculty-staff-information .field-jobtitle")[i].text.strip
  link = page.search(".faculty-staff-information .field-full-name a")[i]["href"]
  link = "https://www.ece.gatech.edu" + link
  CSV.open("../data/georgia.csv", "a") do |csv|
    csv << [name,email,link,work]
  end
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
