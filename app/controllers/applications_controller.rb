class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    if params[:search].present?
      @application = Application.find(params[:id])
      @pet = Pet.search(params[:search])
      binding.pry
    else
      @application = Application.find(params[:id])
      # binding.pry
      @pet = Pet.find(params[:pet_id])
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:alert] = "You must fill in all fields"
      redirect_to "/applications/new"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end