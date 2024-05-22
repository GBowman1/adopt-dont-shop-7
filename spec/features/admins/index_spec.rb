require "rails_helper"

describe "Admin Index" do
    describe "As a Visitor" do
        before :each do
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
        end
    
        it "Has links to admin pages" do
    
            visit "/admin/index"

            expect(page).to have_link("View Shelters Admin page")
            expect(page).to have_link("View #{@app1.name} Form")
            expect(page).to have_link("View #{@app2.name} Form")
        end
    end
end