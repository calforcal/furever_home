class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name, :street_address, :city, :state, :zip_code

  def find_pet_app(pet_id)
    pet_applications.where(pet_id: pet_id).first
  end
end