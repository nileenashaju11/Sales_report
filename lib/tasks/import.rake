require 'csv'
namespace :import do
  task :data => :environment do
    csv_text = File.read('lib/tasks/sale_data.csv')
    csv = CSV.parse(csv_text, :headers => true)
     csv.each do |row|
     SaleDetail.create!(row.to_hash)
    end
  end
end 





