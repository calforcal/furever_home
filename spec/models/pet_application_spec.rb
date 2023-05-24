require "rails_helper"

RSpec.describe PetApplication, type: :model do
  it { should belong_to :pet }
  it { should belong_to :application }

  it { should validate_presence_of :pet_status}
  it { should validate_numericality_of :pet_id}
  it { should validate_numericality_of :application_id}
end