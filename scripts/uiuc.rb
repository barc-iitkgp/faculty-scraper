require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","EMAIL ID","COURSES / AREA")

page = bot.get("http://illinois.edu/ds/detail?departmentId=illinois.eduKP434")
num = page.search(".ws-ds-table-col1").count
for i in (0..num-1)
    name = page.search(".ws-ds-table-col1")[i].text.strip.to_s
    name = name.chomp(',')
    email = page.search(".ws-ds-table-col3")[i].text.strip.to_s
    email = email[17..-3]
    email_ender = "@illinois.edu"
    email = email + email_ender
    dept = "Department of Computer Science"
    csv_write(filename,name,email,dept)
    puts (i+1).to_s + "/" + num.to_s + " completed"
end