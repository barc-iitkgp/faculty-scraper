require 'csv'
require 'mechanize'

bot = Mechanize.new
bot.follow_meta_refresh = true 
bot.verify_mode = OpenSSL::SSL::VERIFY_NONE

page = bot.get("https://ed.stanford.edu/faculty/profiles")
CSV.open("../data/stanford.csv", "a") do |csv|
  csv << ["NAME","EMAIL ID","PHONE NUMBER","PROFILE LINK"]
end

num =  page.search(".field-content .well").count
for i in (0..num-1)
  var = page.search(".field-content .well")[i].children.children.children.children
  name = var.first.text
  email = var.children[1].parent['href'].gsub("mailto:","")
  phone = var.last.text
  link = "https://ed.stanford.edu" + var.first.children.first['href']
  if phone == "Email"
    phone = ""
  end
  CSV.open("../data/stanford.csv", "a") do |csv|
    csv << [name,email,phone,link]
  end
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
