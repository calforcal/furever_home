class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
    @pets = @application.pets

    if params[:search]
      @found_pets = Pet.search(params[:search]).adoptable
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
      flash[:alert] = "Error: #{error_message(@application.errors)}"
      redirect_to "/applications/new"
    end
  end

  def update
    @application = Application.find(params[:app_id])
    @application.update(application_params)
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  private
    def application_params
      params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status).with_defaults(status: "In Progress")
    end
end