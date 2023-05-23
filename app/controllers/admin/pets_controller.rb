class Admin::PetsController < ApplicationController
  def update
    pet = Pet.find(params[:id])
    application = Application.find(params[:app_id])
    pet.update(pet_params)
    require 'pry'; binding.pry
    pet.save
    redirect_to "/admin/applications/#{application.id}"
  end

  private

  def pet_params
    params.permit(:id, :name, :age, :breed, :adoptable, :shelter_id)
  end
end