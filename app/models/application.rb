class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  validates_presence_of :name, :street_address, :city, :state, :zip_code

  def find_pet_app(pet_id)
    pet_applications.where(pet_id: pet_id).first
  end

  def update_status
    pending = self.pet_applications.where(pet_status: 'Pending Adoption').any?
    rejected = self.pet_applications.where(pet_status: 'Rejected').any?
    approved = self.pet_applications.where(pet_status: 'Approved').any?
    if pending != true && rejected != true && approved == true
      self.update(status: "Approved")
    elsif rejected == true
      self.update(status: "Rejected")
    end
  end
end