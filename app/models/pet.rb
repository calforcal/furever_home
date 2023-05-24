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

  def pet_app_statuses
    pet_applications.pluck(:pet_status)
  end

  def self.available_for_adoption
    select("pets.*").joins(:pet_applications).where.not('pet_applications.pet_status => Approved')
  end
end
