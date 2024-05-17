require "rails_helper"


describe "Application Show" do
    describe "As a Vistior" do
        it "Has a Show Page that shows Applicant Info" do
            app = Application.create!(
                                    name: "Chee Lee",
                                    street_address: "123 street",
                                    city: "New Orleans",
                                    state: "Louisana",
                                    zip_code: "12345",
                                    description: "I will love that dog till I die",
                                    status: "In Progress",
            )

            visit "/applications/#{app.id}"

            within "#applicant_info" do
                expect(page).to have_content(app.name)
                expect(page).to have_content(app.street_address)
                expect(page).to have_content(app.city)
                expect(page).to have_content(app.state)
                expect(page).to have_content(app.zip_code)
                expect(page).to have_content(app.description)
                expect(page).to have_content(app.status)
            end
        end
        
        #story 5
        it 'can add pets to application if it is not submitted' do
            app = Application.create!(
                name: "Chee Lee",
                street_address: "123 street",
                city: "New Orleans",
                state: "Louisana",
                zip_code: "12345",
                description: "I will love that dog till I die",
                status: "In Progress",
            )

            hazel = Pets.create!(
                name: "Hazel",
                breed: "German Shepherd",
                age: 5,
                adoptable: true
            )

            visit "/applications/#{app.id}"

            expect(page).to have_content("Add a Pet to this Application")
            expect(find("form")).to have_content("Seach pets by name")

            within "#search_pets_by_name" do
                fill_in "Seach pets by name", with: "Hazel"
            end
            click_button "Submit"

            expect(page).to have_current_path("/applications/#{app.id}")
            within "#pet_search_results" do
                expect(page).to have_content("Name: Hazel")
            end

            #not sure if I wrote the appear before test correctly, at end of story 4
            expect("#search_pets_by_name").to appear_before("#pet_search_results")
        end

        it "can add a pet to an application" do
            app = Application.create!(
                name: "Chee Lee",
                street_address: "123 street",
                city: "New Orleans",
                state: "Louisana",
                zip_code: "12345",
                description: "I will love that dog till I die",
                status: "In Progress",
            )

            hazel = Pets.create!(
                name: "Hazel",
                breed: "German Shepherd",
                age: 5,
                adoptable: true
            )

            visit "/applications/#{app.id}"

            within "#search_pets_by_name" do
                fill_in "Seach pets by name", with: "Hazel"
            end
            click_button "Submit"

            within "#pet_search_results" do
                expect(page).to have_content("Name: Hazel")
                expect(page).to have_button("Adopt this Pet")
            end

            within "#pets_to_adopt" do
                expect(page).to_not have_content("Hazel")
            end

            click_button "Adopt this Pet"

            expect(page).to have_current_path("applications/#{app.id}")

            within "#pets_to_adopt" do
                expect(page).to have_content("Hazel")
            end
        end

        it "can submit an application" do
            app = Application.create!(
                name: "Chee Lee",
                street_address: "123 street",
                city: "New Orleans",
                state: "Louisana",
                zip_code: "12345",
                description: "I will love that dog till I die",
                status: "In Progress",
            )

            hazel = Pets.create!(
                name: "Hazel",
                breed: "German Shepherd",
                age: 5,
                adoptable: true
            )

            visit "/applications/#{app.id}"
            within "#search_pets_by_name" do
                fill_in "Seach pets by name", with: "Hazel"
            end
            click_button "Submit"
            click_button "Adopt this Pet"

            expect(find("form")).to have_content("Why I would make a good owner to these pet(s)")

            within "#submit form" do
                fill_in "Why I would make a good owner to these pet(s)", with: "I will love them till I die"
            end

            expect(page).to have_link("Submit Application")
            click_button "Submit Application"

            expect(page).to have_current_path("/application/#{app.id}")

            expect(page).to have_content("Status: Pending")
            within "#pets_to_adopt" do
            expect(page).to have_content("Hazel")
            end
            #(not sure if this is how to write 'not have_content of the id #search_pets_by_name')
            # expect(page).to_not have_content("#search_pets_by_name")
            #will have to review this test to make more robust
            expect(page).to_not have_content("Seach pets by name")
            expect(page).to_not have_link("Adopt this Pet")
        end
    end
end
