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
    if field.count == 2
      csv << [field[0],field[1]]
    elsif field.count == 3 
      csv << [field[0],field[1],field[2]]
    elsif field.count == 4 
      csv << [field[0],field[1],field[2],field[3]]
    elsif field.count == 5 
      csv << [field[0],field[1],field[2],field[3],field[4]]
    elsif field.count == 6 
      csv << [field[0],field[1],field[2],field[3],field[4],field[5]]    
    end
  end
    
end