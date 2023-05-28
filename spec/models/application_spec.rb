require "rails_helper"

RSpec.describe Application, type: :model do
  it { should have_many :pet_applications }
  it { should have_many(:pets).through(:pet_applications) }

  let!(:shelter_1) { Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
  let!(:pet_1) { shelter_1.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true) }
  let!(:application) { Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "Pending") }
  let!(:petapp_1) { PetApplication.create!(pet: pet_1, application: application) }

  describe "#instance methods" do
    it "can return the pet application for a specific pet and app id" do
      expect(application.find_pet_app(pet_1.id)).to eq(petapp_1)
    end

    it "can check pet applications to see if decisions were made and update the status of the application" do

      application.update_status
      expect(application.status).to eq("Pending")

      petapp_1.update(pet_status: "Approved")
      application.update_status

      expect(application.status).to eq("Approved")
    end
  end
end