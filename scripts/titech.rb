require 'uri'
require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","CONTACT NUMBER","PAGE")

mainpage , i , j = bot.get("http://www.titech.ac.jp/english/graduate_school/faculty/") , 1 , 1 
mainpage.search(".staffsList01 li .titBox .titWrap").each do |course_page|
        course_page_link = "http://www.titech.ac.jp"+course_page["href"]
        bot.get(course_page_link).search(".trSubtext").each do |prof|
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
end