require "rails_helper"


describe "Application Show" do
    describe "As a Vistior" do
        before :each do
            @app = Application.create!(
                name: "Chee Lee",
                street_address: "123 street",
                city: "New Orleans",
                state: "Louisana",
                zip_code: "12345",
                description: "I will love that dog till I die",
                status: "In Progress",
            )
            @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
            @hazel = @shelter_1.pets.create!(
                name: "Hazel",
                breed: "German Shepherd",
                age: 5,
                adoptable: true
            )
        end

        it "Has a Show Page that shows Applicant Info" do

            visit "/applications/#{@app.id}"

            within "#applicant_info" do
                expect(page).to have_content(@app.name)
                expect(page).to have_content(@app.street_address)
                expect(page).to have_content(@app.city)
                expect(page).to have_content(@app.state)
                expect(page).to have_content(@app.zip_code)
                expect(page).to have_content(@app.description)
                expect(page).to have_content(@app.status)
            end
        end
        it 'can search pets to add to application if it is not submitted' do
            
            visit "/applications/#{@app.id}"

            within "#add_pet" do
                expect(page).to have_content("Add a Pet to this Application")
                expect(find("form")).to have_content("Search pets by name")
            end

            within "#search_pets_by_name" do
                fill_in "search", with: "Hazel"
            end
            click_button "Search"

            within "#pet_search_results" do
                expect(page).to have_content("Name: #{@hazel.name}")
            end
            expect("Search pets by name").to appear_before("Pet search results")
        end
        it "can add a pet to an application" do

            visit "/applications/#{@app.id}"

            within "#search_pets_by_name" do
                fill_in "search", with: "Hazel"
            end
            click_button "Search"

            within "#pet_search_results" do
                expect(page).to have_content("Name: #{@hazel.name}")
                expect(page).to have_link("Adopt #{@hazel.name}")
            end

            within "#pets_to_adopt" do
                expect(page).to_not have_content("Hazel")
            end
            click_link "Adopt #{@hazel.name}"
            expect(page).to have_current_path("/applications/#{@app.id}?adopt=#{@hazel.id}")
            within "#pets_to_adopt" do
                expect(page).to have_content("Name: #{@hazel.name}")
            end
        end
        it "can submit an application" do

            visit "/applications/#{@app.id}"
            within "#search_pets_by_name" do
                fill_in "search", with: "Hazel"
            end
            click_button "Search"
            click_link "Adopt #{@hazel.name}"
            within "#submit_form" do
                expect(find("form")).to have_content("What makes me a good owner to these pet(s)")
                fill_in "why_me", with: "I will love them till I die"
            end
            
            expect(page).to have_button("Submit Application")
            click_button "Submit Application"
            
            expect(page).to have_current_path("/applications/#{@app.id}")
            expect(page).to have_content("Status: Pending")

            within "#pets_to_adopt" do
            expect(page).to have_content("Name: #{@hazel.name}")
            end

            expect(page).to_not have_selector("#add_pet")
            expect(page).to_not have_content("Seach pets by name")
            expect(page).to_not have_link("Adopt #{@hazel.name}")
        end
        it 'cannot submit application without adding pet' do

            visit "/applications/#{@app.id}"
            expect(page).to have_selector("#pets_to_adopt")
            expect(page).to_not have_selector("#submit_form")
            expect(page).to_not have_link("Submit Application")
        end
        it 'can find pet by partial search' do

            visit "/applications/#{@app.id}"
            within "#search_pets_by_name" do
                fill_in "search", with: "zel"
            end
            click_button "Search"

            within "#pet_search_results" do
                expect(page).to have_content("Name: #{@hazel.name}")
            end
        end
        it 'searches pets regardless of casing of input' do
            visit "/applications/#{@app.id}"
            within "#search_pets_by_name" do
                fill_in "search", with: "HAzel"
            end
            click_button "Search"

            within "#pet_search_results" do
                expect(page).to have_content("Name: #{@hazel.name}")
            end
        end
    end
end
