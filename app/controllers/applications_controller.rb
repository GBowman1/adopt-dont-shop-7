class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:adopt].present?
      pet = Pet.find(params[:adopt])
      @application.add_pet(pet)
    elsif params[:search].present?
      @pet = Pet.search(params[:search])
    else
      @pet = []
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