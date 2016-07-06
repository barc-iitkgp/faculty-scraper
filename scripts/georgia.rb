require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","PAGE","WORK")

page = bot.get("https://www.ece.gatech.edu/faculty-staff-directory?field_group_filter_value=1")
num =  page.search(".faculty-staff-information").count 
for i in (0..num-1)
  name = page.search(".faculty-staff-information .field-full-name")[i].text.strip
  email = page.search(".faculty-staff-information .field-email-address")[i].children[1]["href"].gsub("mailto:","")
  work = page.search(".faculty-staff-information .field-jobtitle")[i].text.strip
  link = page.search(".faculty-staff-information .field-full-name a")[i]["href"]
  link = "https://www.ece.gatech.edu" + link
  csv_write(filename,name,email,link,work)
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
