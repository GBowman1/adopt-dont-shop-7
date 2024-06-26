# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

@shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
@shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
@shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)

@pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
@pet_2 = @shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
@pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
@pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)

@app1 = Application.create!(
  name: "Chee Lee",
  street_address: "123 street",
  city: "New Orleans",
  state: "Louisana",
  zip_code: "12345",
  description: "I will love that dog till I die",
  status: "In Progress",
)

@app2 = Application.create!(
  name: "Garret Bowman",
  street_address: "321 street",
  city: "Las Vegas",
  state: "Nevada",
  zip_code: "54321",
  description: "I will love that dog till it dies",
  status: "In Progress",
)