require "rails_helper"

RSpec.describe "the admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: false)
    @pet_2 = @shelter_2.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: "Ann", breed: "ragdoll", age: 5, adoptable: true)
    @app1 = Application.create!(
      name: "Chee Lee",
      street_address: "123 street",
      city: "New Orleans",
      state: "Louisana",
      zip_code: "12345",
      description: "I will love that dog till I die",
      status: "In Process",
    )
    @app2 = Application.create!(
      name: "Garret Bowman",
      street_address: "321 street",
      city: "Las Vegas",
      state: "Nevada",
      zip_code: "54321",
      description: "I will love that dog till it dies",
      status: "Pending",
    )
  end
  describe "As a Vistior" do
    #story 10
    it 'see a section with shelters listed reverse alphabetical by name' do
      visit "/admin/shelters"
# save_and_open_page
      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_2.name}")
      expect(page).to have_content("#{@shelter_3.name}")
      expect("#{@shelter_2.name}").to appear_before("#{@shelter_1.name}")
      expect("#{@shelter_2.name}").to appear_before("#{@shelter_3.name}")
      expect("#{@shelter_3.name}").to appear_before("#{@shelter_1.name}")
  end

    #story 11
    it 'see name of every shelter that has a pending application' do
      @app2.add_pet(@pet_1)
      @app2.add_pet(@pet_2)
      @app1.add_pet(@pet_3)

      visit "/admin/shelters"
# save_and_open_page
      expect(page).to have_selector("#with_pending_app")
      expect(page).to have_content("Shelters with Pending Applications")

      within "#with_pending_app" do
        expect(page).to have_content("#{@shelter_1.name}")
        expect(page).to have_content("#{@shelter_2.name}")
        expect(page).to_not have_content("#{@shelter_3.name}")
      end
    end
  end
end