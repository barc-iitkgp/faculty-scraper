require 'uri'
require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","CONTACT NUMBER","PAGE")

page = bot.get("https://www.ee.ethz.ch/the-department/people-a-z.html")
num , i = page.search(".trSubtext").count , 1
page.search(".trSubtext").each do |prof|
        info = prof.search("td")
        name = info[0].text.strip
        phone = info[2].text.strip
        email = ""
        email = info[3].children.children.text.gsub("eval","").gsub("unescape","").gsub("(","").gsub(")","").gsub("\'","")
        email = email.length==0 ? "" : URI.unescape(email).split(">")[1].split("<")[0]
        link = "https://www.ee.ethz.ch"+info[0].search("a")[0]["href"]
        csv_write(filename,name,email,phone,link)
        puts i.to_s + "/" + num.to_s + " completed" 
        i = i+1
end