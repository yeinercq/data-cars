class CarsController < ApplicationController
  require "csv"
  before_action :set_file, only: [:import]
  
  def index
    @cars = Car.all
  end

  def import
    # Controller validation to csv file extention
    return redirect_to cars_path, notice: "csv file only, please!" unless @file&.content_type == "text/csv"
    # Call to import cars service
    success, message = CsvImportCarsService.new.call(@file)
    # Response
    if success
      redirect_to cars_path, notice: "Data has been imported successfully."
    else
      redirect_to cars_path, notice: "Import cars error.", status: :unprocessable_entity
    end
  end

  def search
  end

  private

  def set_file
    @file = params[:file]
  end
end
