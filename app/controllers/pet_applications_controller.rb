class PetApplicationsController < ApplicationController
  def create
    @pet_app = PetApplication.create!(pet_application_params)
    redirect_back fallback_location: "/applications"
  end

  def update
    pet_app = PetApplication.find(params[:id])
    pet_app.update(pet_application_params)
    application = pet_app.application
    pet_app.save
    redirect_to "/admin/applications/#{application.id}"
  end

  private
    def pet_application_params
      params.permit(:pet_id, :application_id, :pet_status)
    end
end