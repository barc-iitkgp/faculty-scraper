require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","EMAIL ID","PHONE NUMBER","WORK")

page = bot.get("http://www.seas.harvard.edu/faculty-research/people/ladder")
num =  page.search(".field-name-title h2").count
for i in (0..num-1)
  name = page.search(".field-name-title h2")[i].text
  email = page.search(".field-name-field-email .field-item")[i].text
  begin
    phone = page.search(".field-name-field-phone .field-item")[i].text
  rescue
    phone = ""
  end  
  work = page.search(".field-name-field-primary-title .field-item")[i].text
  csv_write(filename,name,email,phone,work)
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
