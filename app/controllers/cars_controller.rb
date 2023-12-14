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
    @data = {}
    request = Car.where(brand: params[:brand])
                .where(model: params[:model])
                .select("production_year, avg(price) as price")
                .group("production_year")

    request.each {|r| @data.store(r.production_year, r.price) }
    
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def models
    @models = Car.where(brand: params[:model]).group(:model).count.map { |key, value| [key, key] }
    @target = params[:target]
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def set_file
    @file = params[:file]
  end
end
