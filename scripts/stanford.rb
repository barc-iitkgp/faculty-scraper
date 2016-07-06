require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","EMAIL ID","PHONE NUMBER","PROFILE LINK")

page = bot.get("https://ed.stanford.edu/faculty/profiles")
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
  csv_write(filename,name,email,phone,link)
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
