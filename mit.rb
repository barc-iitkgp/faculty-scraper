require 'csv'
require 'mechanize'

bot = Mechanize.new
bot.follow_meta_refresh = true 
bot.verify_mode = OpenSSL::SSL::VERIFY_NONE

page = bot.get("https://www.eecs.mit.edu/people/faculty-advisors")
CSV.open("data/mit.csv", "a") do |csv|
  csv << ["NAME","EMAIL ID","COURSES / AREA"]
end

num =  page.search(".views-field-title .field-content").count
for i in (0..num-1)
  name = page.search(".views-field-title .field-content")[i].children.text
  email = page.search(".views-field-field-person-email")[i].text
  dept = page.search(".views-field-term-node-tid")[i].children.text.strip
  CSV.open("data/mit.csv", "a") do |csv|
    csv << [name,email,dept]
  end
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
