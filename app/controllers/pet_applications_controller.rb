class PetApplicationsController < ApplicationController
  def create
    @pet_app = PetApplication.create!(pet_application_params)
    redirect_back fallback_location: "/applications"
  end

  private
    def pet_application_params
      params.permit(:pet_id, :application_id)
    end
end