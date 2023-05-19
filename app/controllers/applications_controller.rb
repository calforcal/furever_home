class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
    if params[:app_status] == "In Progress"
      @application.status = "In Progress"
    end
  end

  def new
    @application = Application.new
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