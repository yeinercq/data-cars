class CarsController < ApplicationController
  before_action :set_file, only: [:import]
  def index
    @cars = Car.all
  end

  def import
    return redirect_to cars_path, notice: "csv file only, please!" unless @file.content_type == "text/csv"
    redirect_to cars_path, notice: "Data has been imported successfully."
  end

  private

  def set_file
    @file = params[:file]
  end
end
