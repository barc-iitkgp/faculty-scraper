require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","EMAIL ID","PROFILE LINK")

page = bot.get("http://www.eecs.berkeley.edu/Faculty/Lists/list.shtml")
num , i =  page.search("table tr img").count , 1
page.search("table tr img").each do |p|
  name = p["alt"].gsub("photo of ","")
  username = p["src"][50..-5]
  link = "http://www.eecs.berkeley.edu/Faculty/Homepages/#{username}.html"
  email = ""
  possible_email = p.parent.parent.text.strip.split(" ")
  possible_email.each do |pe|
    if ((pe.include? "@") && (email.empty?))
      email = pe
    end
  end
  if ((!email.empty?) && (!(email.include? ".")))
    email = email + ".berkeley.edu"
  end   
  csv_write(filename,name,email,link)
  puts i.to_s + "/" + num.to_s + " completed"
  i = i+1 
end
