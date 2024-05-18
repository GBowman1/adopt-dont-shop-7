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
        
        # story 4
        it 'can add pets to application if it is not submitted' do
            
            visit "/applications/#{@app.id}"
# save_and_open_page
            expect(page).to have_content("Add a Pet to this Application")
            expect(find("form")).to have_content("Search pets by name")

            within "#search_pets_by_name" do
            fill_in "search", with: "Hazel"
            end
            click_button "Search"

            # not sure how to check path with query params added to path
            # expect(page).to have_current_path("/applications/#{@app.id}")
# save_and_open_page
            within "#pet_search_results" do
            expect(page).to have_content("Name: #{@hazel.name}")
            end

            #not sure if I wrote the appear before test correctly, at end of story 4
            expect("Search pets by name").to appear_before("Pet search results")
        end

        # story 5
        it "can add a pet to an application" do

            visit "/applications/#{@app.id}"

            within "#search_pets_by_name" do
                fill_in "search", with: "Hazel"
            end
            click_button "Search"

            within "#pet_search_results" do
                expect(page).to have_content("Name: #{@hazel.name}")
                expect(page).to have_link("Adopt #{@hazel.name}")
                # expect(page).to have_button("Adopt #{@hazel.name}")
                #I couldn't get the button to send query params in path
            end

            within "#pets_to_adopt" do
                expect(page).to_not have_content("Hazel")
            end
# save_and_open_page
            # click_button "Adopt #{@hazel.name}"
            click_link "Adopt #{@hazel.name}"

            # how do you want to handle @applicant.pets
            # patch "/applications/#{@app.id}.?adopt=#{pet.id}", to: applications#show"
            # conditional for adopt
            # made .adopt_pet model instance method and test

            #may not be correct path with query params
            # expect(page).to have_current_path("/applications/#{@app.id}")

# save_and_open_page
            within "#pets_to_adopt" do
                expect(page).to have_content("Name: #{@hazel.name}")
            end
        end

        # story 6
        it "can submit an application" do

            visit "/applications/#{@app.id}"
            within "#search_pets_by_name" do
                fill_in "search", with: "Hazel"
            end
            click_button "Search"
            click_link "Adopt #{@hazel.name}"

            expect(find("form")).to have_content("Why I would make a good owner to these pet(s)")

            within "#submit_form" do
                fill_in "Why I would make a good owner to these pet(s)", with: "I will love them till I die"
            end

            expect(page).to have_link("Submit Application")
            click_button "Submit Application"

            #may not be correct path with query params
            expect(page).to have_current_path("/application/#{@app.id}")

            expect(page).to have_content("Status: Pending")
            within "#pets_to_adopt" do
            expect(page).to have_content("Name: #{@hazel.name}")
            end
            #(not sure if this is how to write 'not have_content of the id #search_pets_by_name')
            # expect(page).to_not have_content("#search_pets_by_name")
            #will have to review this test to make more robust
            expect(page).to_not have_content("Seach pets by name")
            expect(page).to_not have_link("Adopt #{@hazel.name}")
        end

        # story 7
        it 'cannot submit application without adding pet' do

            visit "/applications/#{@app.id}"

            #same as previous story, not sure how to write 'not seeing a section by id'
            # expect(page).to_not have_content("#submit_form")
            expect(page).to_not have_link("Submit Application")
        end
    end
end
