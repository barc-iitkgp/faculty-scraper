require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","EMAIL ID","PROFILE LINK")

page = bot.get("http://en.coe.pku.edu.cn/Faculty-by-Dept/index.htm")
num , i =  page.search(".capitalize li").count , 1
page.search(".capitalize li").each do |p|
  name = p.search("div div a")[1].text.strip.chomp
  link = "http://en.coe.pku.edu.cn" + p.search("div div a")[0]["href"]
  email = ""
  p.search("div div span").each do |e|
    if e.text.include? ".edu.cn"
      email = e.text
    end
  end
  csv_write(filename,name,email,link)
  puts i.to_s + "/" + num.to_s + " completed"
  i = i+1 
end
