require 'csv'
require 'mechanize'

def mechanize_bot filename
  
  bot = Mechanize.new
  bot.follow_meta_refresh = true 
  bot.verify_mode = OpenSSL::SSL::VERIFY_NONE

  filename = "../data/"+filename.gsub(".rb",".csv") 
  File.delete(filename) if File.exists? filename

  to_return = []
  to_return[0] = bot
  to_return[1] = filename    

  return to_return

end

def csv_write filename , *field
  
  CSV.open(filename, "a") do |csv|
    csv << field
  end
    
end