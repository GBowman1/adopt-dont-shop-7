class AdminApplicationsController < ApplicationController
    def show
        @application = Application.find(params[:id])
    end

    def update
        @application = Application.find(params[:id])
        if params[:approve]
            pet = Pet.find(params[:approve])
            @application.approve_pet(pet)
        elsif params[:reject]
            pet = Pet.find(params[:reject])
            @application.reject_pet(pet)
        end
        redirect_to "/admin/applications/#{params[:id]}"
    end

    # private
    # def application_params
    #     params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
    # end
end