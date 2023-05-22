require "rails_helper"

RSpec.describe "/admin/shelters, admin index page", type: :feature do
  let!(:shelter_1) { Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)}
  let!(:shelter_2) { Shelter.create!(name: "All da Pets shelter", city: "Tacoma, WA", foster_program: false, rank: 6) }
  let!(:shelter_3) { Shelter.create!(name: "Zippy Do Da shelter", city: "Ocean View, IA", foster_program: false, rank: 2) }

  it "displays all shelters in the system in Z-to-A form" do
    visit "/admin/shelters"
    save_and_open_page
    expect(page).to have_content("All Shelters")
    expect(shelter_3.name).to appear_before(shelter_1.name)
    expect(shelter_1.name).to appear_before(shelter_2.name)
  end
end