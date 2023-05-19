require "rails_helper"

RSpec.describe "the applications show page" do

  let!(:shelter) { Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9) }
  let!(:pet) { shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id) }
  let!(:application) { Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "In Progress") }

  it "shows the application and its attributes" do
    application.pets << pet

    visit "/applications/#{application.id}"
    save_and_open_page
    expect(page).to have_content("#{application.name}")
    expect(page).to have_content("Address: #{application.street_address} #{application.city}, #{application.state} #{application.zip_code}")
    expect(page).to have_content("Description: #{application.description}")
    expect(page).to have_content("Status: #{application.status}")
    expect(page).to have_content("Pets applying for:")
    expect(page).to have_content("Pet Name: #{pet.name}")
  end
end