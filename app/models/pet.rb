class Pet < ApplicationRecord
  validates :name, presence: true
  validates :age, presence: true, numericality: true
  
  belongs_to :shelter
  
  has_many :pet_applications
  has_many :applications, through: :pet_applications

  def shelter_name
    shelter.name
  end

  def self.adoptable
    where(adoptable: true)
  end

  def update_adoptability
    self.update(adoptable: false)
  end

  def self.find_pet(pet_id)
    where(id: pet_id).first
  end
end
