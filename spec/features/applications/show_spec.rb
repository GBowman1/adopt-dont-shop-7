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
    end
end
