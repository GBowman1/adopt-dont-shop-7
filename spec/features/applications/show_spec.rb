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
        
    end
end
