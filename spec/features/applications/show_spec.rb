require "rails_helper"

RSpec.describe "the applications show page" do

  let!(:shelter) { Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9) }
  let!(:pet) { shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true) }
  let!(:application) { Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "In Progress") }
  let!(:application_2) { Application.create!(name: "MC Callahan", street_address: "125 Kingsland Blvd.", city: "Brooklyn", state: "NY", zip_code: "11222", description: "I just hate pets so much!", status: "In Progress") }

  it "shows the application and its attributes" do
    application.pets << pet

    visit "/applications/#{application.id}"
    
    expect(page).to have_content("#{application.name}")
    expect(page).to have_content("Address: #{application.street_address} #{application.city}, #{application.state} #{application.zip_code}")
    expect(page).to have_content("Description: #{application.description}")
    expect(page).to have_content("Status: #{application.status}")
    expect(page).to have_content("Pets applying for:")
    expect(page).to have_content("#{pet.name}")

    expect(page).to_not have_content("#{application_2.name}")
    expect(page).to_not have_content("Address: #{application_2.street_address} #{application_2.city}, #{application_2.state} #{application_2.zip_code}")
    expect(page).to_not have_content("Description: #{application_2.description}")

    click_on(pet.name)

    expect(current_path).to eq("/pets/#{pet.id}")
  end
end