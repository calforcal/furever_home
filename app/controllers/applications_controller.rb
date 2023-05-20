class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
    @pets = @application.pets
  end

  def new
  end

  def create
    @application = Application.create!(application_params)

    redirect_to "/applications/#{@application.id}"
  end

  private
    def application_params
      params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
    end
end