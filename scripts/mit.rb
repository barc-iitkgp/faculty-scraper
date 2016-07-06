require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","EMAIL ID","COURSES / AREA")

page = bot.get("https://www.eecs.mit.edu/people/faculty-advisors")
num =  page.search(".views-field-title .field-content").count
for i in (0..num-1)
  name = page.search(".views-field-title .field-content")[i].children.text.strip.to_s
  email = page.search(".views-field-field-person-email")[i].text.strip.to_s
  dept = page.search(".views-field-term-node-tid")[i].children.text.strip.to_s
  csv_write(filename,name,email,dept)
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
