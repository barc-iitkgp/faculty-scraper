require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","PAGE")

mainpage = bot.get("http://stisrv13.epfl.ch/profs/img/people.js")
num , i = mainpage.body.split("set_personal_info").count - 1 , 0
mainpage.body.split("\n").each do |line|
  if line.include? "set_personal_info"
    username = line.split("set_personal_info(")[1].split(",")[0].gsub("\"","")
    link = "https://people.epfl.ch/#{username}"
    email = "#{username}@epfl.ch".gsub(" ","")
    name = line.split("set_personal_info(")[1].split(",")[2].gsub("\"","").encode("iso-8859-1").force_encoding("utf-8") + " " +line.split("set_personal_info(")[1].split(",")[1].gsub("\"","").downcase.encode("iso-8859-1").force_encoding("utf-8")
    name = name.gsub("&","").gsub(";","").to_s
    csv_write(filename,name,email,link)
    puts (i+1).to_s + "/" + num.to_s + " completed" 
    i = i+1
  end
end