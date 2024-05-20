require "rails_helper"

describe "Application Show" do
    describe "As a admin" do
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
            @app.add_pet(@hazel)
        end

        # As a visitor
        # When I visit an admin application show page ('/admin/applications/:id')
        # For every pet that the application is for, I see a button to approve the application for that specific pet
        # When I click that button
        # Then I'm taken back to the admin application show page
        # And next to the pet that I approved, I do not see a button to approve this pet
        # And instead I see an indicator next to the pet that they have been approved
        it "Can approve a pet on an application" do
            visit "/admin/applications/#{@app.id}"

            within "#pet-request" do
                expect(page).to have_link("Approve")
            end
            within "#pet-request" do
            click_link "Approve"
                expect(page).to have_current_path("/admin/applications/#{@app.id}")
                expect(page).to have_content("Approved")
                expect(page).to_not have_link("Approve")
            end
        end
        it "Can reject a pet on an application" do
            visit "/admin/applications/#{@app.id}"

            within "#pet-request" do
                expect(page).to have_link("Reject")
            end
            within "#pet-request" do
            click_link "Reject"
                expect(page).to have_current_path("/admin/applications/#{@app.id}")
                expect(page).to have_content("Rejected")
                expect(page).to_not have_link("Reject")
            end
        end
        it "does not affect other applications with the same pet" do
            app2 = Application.create!(
                name: "Chee Lee",
                street_address: "123 street",
                city: "New Orleans",
                state: "Louisana",
                zip_code: "12345",
                description: "I will love that dog till I die",
                status: "In Progress",
            )
            app2.add_pet(@hazel)

            visit "/admin/applications/#{app2.id}"

            within "#pet-request" do
                expect(page).to have_link("Approve")
            end

            within "#pet-request" do
            click_link "Approve"
            end

            visit "/admin/applications/#{@app.id}"
            within "#pet-request" do
                expect(page).to have_link("Reject")
                expect(page).to have_link("Approve")
                expect(page).to_not have_content("Approved")
                expect(page).to_not have_content("Rejected")
            end
        end
    end
end