require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","PAGE")

mainpage = bot.get("http://www.tudelft.nl/en/about-tu-delft/find-staff/professors/")
num , j = mainpage.search(".found").text.gsub("Number of people found: ","").to_i , 1
pagination = num%20 == 0 ? (num/20) : (num/20) + 1
for i in (1..pagination)
    page = bot.get("http://www.tudelft.nl/en/about-tu-delft/find-staff/professors/faculty/tud/q/%2A/page/#{i.to_s}")
    page.search("table th").each do |person|
        username = person.children.children.children.last["href"]
        username = username[27..username.length-2]
        name = person.children.children.children.last.text
        link = "http://staff.tudelft.nl/en/#{username}"
        email = "#{username}@tudelft.nl".gsub(" ","")
        csv_write(filename,name,email,link)
        puts j.to_s + "/" + num.to_s + " completed" 
        j = j+1
    end
end