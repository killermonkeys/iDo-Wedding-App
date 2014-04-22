require 'csv'

namespace 'ido' do
  desc "Creates an admin user."
  task :admin => :environment do
    begin
      puts "Enter the name of the admin user (e.g. John Smith):"
      name = $stdin.gets.chomp
      a = Guest.create(:name => name)
      a.admin = true
    end until a.save
    msg = %(Admin user successfully created. You may now log in using PIN "#{a.reload.pin}" and last name "#{a.last_name}".)
    puts msg
  end
  desc "Imports a CSV file into an ActiveRecord table"
  task :csv_guest_import, [:filename] => :environment do |task,args|
    csv_text = File.read(args.filename)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      g = Guest.create!(salutation: row[0], first_name: row[1], last_name: row[2], suffix: row[4], pin: row[12])
      g.create_address(line_1: row[5], line_2: row[6], line_3: row[7], city: row[8], state: row[9], 
        zip: row[10], country: row[11])
    end
  end
end