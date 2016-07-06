require_relative 'include/bot'
bot , filename = mechanize_bot($0)
csv_write(filename,"NAME","MAIL ID","PAGE","WORK")

page = bot.get("http://www.history.ox.ac.uk/faculty/staff/a-z.html")
num =  page.search("tr").count 
for i in (1..num-1)
  var = page.search("tr")[i].children.children
  name = var.children.children.text
  email = (var.children.last.text.include? "@") ? var.children.last.text : "" 
  work = (email.empty?) ? var.children.last.text : var.children[var.children.count - 2].text 
  work = work.gsub(";",",")
  link = (var[1]["href"].nil?) ? var[2]["href"] : var[1]["href"]  
  link = "http://www.history.ox.ac.uk/" + link
  csv_write(filename,name,email,link,work)
  puts (i+1).to_s + "/" + num.to_s + " completed" 
end
