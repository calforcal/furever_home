require "rails_helper"

RSpec.describe "/applications/new" do
  let!(:shelter) { Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9) }
  let!(:pet) { shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true) }
  let!(:application) { Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "In Progress") }

  it "can create a new application" do
    visit "/applications/new"
    
    fill_in "Name", with: "Paul McCartney"
    fill_in "Street address", with: "435 Hollywood St"
    fill_in "City", with: "Los Angelos"
    fill_in "State", with: "CA"
    fill_in "Zip code", with: "87309"
    fill_in "Description", with: "I believe there can never be too many cats"

    # save_and_open_page
    click_button "Submit"

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Paul McCartney")
    expect(page).to have_content("435 Hollywood St")
    expect(page).to have_content("Los Angelos")
    expect(page).to have_content("CA")
    expect(page).to have_content("87309")
    expect(page).to have_content("I believe there can never be too many cats")
    expect(page).to have_content("In Progress")
  end
end