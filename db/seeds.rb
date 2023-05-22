# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PetApplication.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Application.destroy_all

shelter = Shelter.create!(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)

pet   = Pet.create!(name: "Scooby", age: 2, breed: "Great Dane", adoptable: true, shelter_id: shelter.id)
pet_1 = Pet.create!(name: "Lucille Bald", breed: "sphynx", adoptable: true, age: 1, shelter_id: shelter.id)
pet_2 = Pet.create!(name: "Lobster", breed: "doberman", adoptable: true, age: 3,  shelter_id: shelter.id)
pet_3 = Pet.create!(name: "Scooter", breed: "Poodle", adoptable: true, age: 10,  shelter_id: shelter.id)
pet_4 = Pet.create!(name: "Sir ScOOts", breed: "Mix", adoptable: true, age: 4,  shelter_id: shelter.id)
pet_5 = Pet.create!(name: "Mister FLUFFball", breed: "border collie", adoptable: true, age: 3,  shelter_id: shelter.id)

application = Application.create!(name: "Ringo Starr", street_address: "123 Canyon Blvd.", city: "Boulder", state: "CO", zip_code: "80304", description: "I just love pets so much!", status: "In Progress")
application_2 = Application.create!(name: "MC Callahan", street_address: "125 Kingsland Blvd.", city: "Brooklyn", state: "NY", zip_code: "11222", description: "I just hate pets so much!", status: "In Progress")
application_3 = Application.create!(name: "Mr Test", street_address: "125 Kingsland Blvd.", city: "Brooklyn", state: "NY", zip_code: "11222", status: "In Progress")
  
PetApplication.create!(pet: pet, application: application)
