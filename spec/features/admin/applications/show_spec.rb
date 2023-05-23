require "rails_helper"

RSpec.describe "/admin/applications/:id, admin-show page" do
    #shelter1
    let!(:shelter_1) { Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
    let!(:pet_1) { shelter_1.pets.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true) }
    let!(:application) { Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "Pending") }
    let!(:petapp_1) { PetApplication.create!(pet: pet_1, application: application) }
    
    #shelter2
    let!(:shelter_2) { Shelter.create!(name: "All da Pets shelter", city: "Tacoma, WA", foster_program: false, rank: 6) }
    let!(:pet_2) { shelter_2.pets.create!(name: "Buddy", age: 2, breed: "Bulldog", adoptable: true) }
    let!(:application_2) { Application.create!(name: "MC Callahan", street_address: "125 Kingsland Blvd.", city: "Brooklyn", state: "NY", zip_code: "11222", status: "In Progress") }
    
    let!(:shelter_3) { Shelter.create!(name: "Zippidy Do Da", city: "Blaine, WA", foster_program: false, rank: 10) }

    it "Admin can approve a pet application for each pet applied for" do

      visit "/admin/applications/#{application.id}"
      save_and_open_page
      within ".applying-for" do
        expect(page).to have_link("#{pet_1.name}")
        expect(page).to have_button("Approve Application for #{pet_1.name}")
        click_button("Approve Application for #{pet_1.name}")
      end
      
      expect(current_path).to eq("/admin/applications/#{application.id}")
      expect(page).to_not have_button("Approve Application for #{pet_1.name}")
      expect(page).to have_content("#{pet_1.name} Approved for Adoption")
    end
end