require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","PAGE","ACADEMIC DIVISION","RESEARCH GROUP")

mainpage = bot.get("http://www.eng.cam.ac.uk/people")
pagination = mainpage.search(".pager-last a").children[0].parent["href"].gsub("/people?field_user_surname_value_1=&field_user_list_category_tid=All&page=","").to_i
for i in (0..pagination)
    page = bot.get("http://www.eng.cam.ac.uk/people?field_user_surname_value_1=&field_user_list_category_tid=All&page=#{i.to_s}")
    page.search(".views-row").each do |prof|
        username = prof.search(".people-full-name a").to_s.split("/")[2].split("\"")[0]
        name = prof.search(".people-full-name a").text
        link = "http://www.eng.cam.ac.uk/profiles/#{username}"
        email = "#{username}@eng.cam.ac.uk".gsub(" ","")
        acad_div = prof.search(".people-division a").text
        research = prof.search(".people-research-group a").text
        csv_write(filename,name,email,link,acad_div,research)
    end
    puts "Page "+ (i+1).to_s + " / " + (pagination+1).to_s + " pages completed" 
end