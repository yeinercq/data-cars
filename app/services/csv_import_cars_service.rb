class CsvImportCarsService
  def call(file)
    # Open csv file
    file = File.open(file)
    csv = CSV.parse(file, headers: true)
    # Array to save each car hash
    cars = []
    csv.each do |row|
      cars << Car.new(row.to_h)
    end
    # Impor cars array to Car db
    Car.import(cars)

    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
