require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","POSITION","CONTACT NUMBER","EMAIL ID","WORK LOCATION")

page = bot.get("http://www.eng.unimelb.edu.au/about/staff")
num , i =  page.search("tr").count , 1
page.search("tr").each do |p|
  unless p.search("td").empty?
    name = p.search("td")[0].text
    work = p.search("td")[1].text
    phone = p.search("td")[2].text
    email = p.search("td")[3].text
    location = p.search("td")[4].text
    csv_write(filename,name,work,phone,email,location)
  end  
  puts i.to_s + "/" + num.to_s + " completed"
  i = i+1 
end
