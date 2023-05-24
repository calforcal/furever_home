class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  validates_presence_of :pet_status
  validates_numericality_of :pet_id, :application_id
end