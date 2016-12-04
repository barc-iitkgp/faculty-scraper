require_relative 'include/bot'
bot, filename = mechanize_bot($0)
csv_write(filename,"NAME","CONTACT NUMBER","PROFILE LINK","FIELD")

page = bot.get("http://www.ee.ucla.edu/all-faculty/")
num , i = page.search("td a").count , 1
page.search("tr").each do |fac|
  fac_name = fac.search("a").text.strip.chomp
  link = "http://www.ee.ucla.edu#{fac.search("a")[0]["href"]}"
  field = fac.text.gsub(fac_name,"").strip
  fac_page = bot.get(link).search(".entry-content").text
  if fac_page.include? "Phone:"
    contact_number = fac_page.split("Phone:")[1][1..14]
  else
    contact_number = ""
  end
  csv_write(filename,fac_name,contact_number,link,field)
  puts i.to_s + " / " + num.to_s + " completed"
  i = i+1
end
