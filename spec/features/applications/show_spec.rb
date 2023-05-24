require "rails_helper"

RSpec.describe "the applications show page" do

  let!(:shelter) { Shelter.create!(name: "Mystery Building", city: "Irvine CA", foster_program: false, rank: 9) }
  
  let!(:pet) { shelter.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true) }
  let!(:pet_2) { shelter.pets.create!(name: "Buddy", age: 2, breed: "Bulldog", adoptable: true) }
  let!(:pet_3) {shelter.pets.create!(name: "Scooter", breed: "Poodle", adoptable: true, age: 10,  shelter_id: shelter.id)}
  let!(:pet_4) {shelter.pets.create!(name: "Sir ScOOts", breed: "Mix", adoptable: true, age: 4,  shelter_id: shelter.id)}

  let!(:application) { Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "In Progress") }
  let!(:application_2) { Application.create!(name: "MC Callahan", street_address: "125 Kingsland Blvd.", city: "Brooklyn", state: "NY", zip_code: "11222", description: "I just hate pets so much!", status: "In Progress") }
  let!(:application_3) { Application.create!(name: "Mr Test", street_address: "125 Kingsland Blvd.", city: "Brooklyn", state: "NY", zip_code: "11222", status: "In Progress") }
  
  let!(:petapp_1) { PetApplication.create!(pet: pet, application: application)}
  let!(:petapp_2) { PetApplication.create!(pet: pet_2, application: application_3)}

  it "shows the application and its attributes" do

    visit "/applications/#{application.id}"
    
    expect(page).to have_content("#{application.name}")
    expect(page).to have_content("Address: #{application.street_address} #{application.city}, #{application.state} #{application.zip_code}")
    expect(page).to have_content("Status: #{application.status}")
    expect(page).to have_content("Pets applying for:")
    expect(page).to have_content("#{pet.name}")

    expect(page).to_not have_content("#{application_2.name}")
    expect(page).to_not have_content("Address: #{application_2.street_address} #{application_2.city}, #{application_2.state} #{application_2.zip_code}")

    click_on(pet.name)

    expect(current_path).to eq("/pets/#{pet.id}")
  end

  it "has ability to add a pet to the application via search" do
    visit "/applications/#{application_2.id}"

    expect(page).to have_content("Add a Pet to this Application")
    
    fill_in "Search", with: "Scooby"
    click_on("Search")

    expect(page).to have_content(pet.name)
    expect(page).to have_button("Adopt this Pet")

    click_button("Adopt this Pet")

    expect(current_path).to eq("/applications/#{application_2.id}")

    within "#pet-#{pet.id}" do
      expect(page).to have_link("#{pet.name}")
    end
  end

  it "can submit an application and update its status after a pet has been added" do
    visit "/applications/#{application_3.id}"
    # save_and_open_page
    expect(page).to have_content("Status: In Progress")

    within ".applying-for" do
      expect(page).to have_link("#{pet_2.name}")
    end

    within "#submit-app" do
      fill_in :description, with: "Because I love pets so much"
      expect(page).to have_button("Submit Application")
      click_button "Submit Application"
    end

    expect(current_path).to eq("/applications/#{application_3.id}")
    expect(page).to have_content("Description: #{application_3.description}")
    expect(page).to have_content("Status: Pending")

    within ".applying-for" do
      expect(page).to have_link("#{pet_2.name}")
    end

    expect(page).to_not have_field(:search)
    expect(page).to_not have_button("Adopt this Pet")
  end

  it "does not show a submit application buttton if no pets have been added" do
    visit "/applications/#{application_2.id}"
    
    expect(page).to_not have_button("Submit Application")
    expect(page).to have_content("Status: In Progress")
    expect(page).to_not have_link("#{pet_2.name}")
    expect(page).to_not have_link("#{pet.name}")
  end

  it "allows user to search for partial names of pets" do
    visit "/applications/#{application_2.id}"

    fill_in "Search", with: "Scoot"
    click_on("Search")

    expect(page).to_not have_content(pet.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)
  end

  it "allows user to do case insensitive searches" do
    visit "/applications/#{application_2.id}"

    fill_in "Search", with: "scoot"
    click_on("Search")

    expect(page).to_not have_content(pet.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)

    fill_in "Search", with: "SCOOt"
    click_on("Search")

    expect(page).to_not have_content(pet.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)

    fill_in "Search", with: "ScOoT"
    click_on("Search")

    expect(page).to_not have_content(pet.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)
  end
end