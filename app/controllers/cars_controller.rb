class CarsController < ApplicationController
  require "csv"
  before_action :set_file, only: [:import]
  def index
    @cars = Car.all
  end

  def import
    return redirect_to cars_path, notice: "csv file only, please!" unless @file.content_type == "text/csv"
    @file = File.open(@file)
    csv = CSV.parse(@file, headers: true)
    cars = []
    csv.each do |row|
      cars << Car.new(row.to_h)
    end
    # debugger
    Car.import(cars)
    redirect_to cars_path, notice: "Data has been imported successfully."
  end

  private

  def set_file
    @file = params[:file]
  end
end
