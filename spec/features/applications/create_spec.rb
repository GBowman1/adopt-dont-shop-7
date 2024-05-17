require "rails_helper"

describe "Application Create" do
  describe "As a Vistior" do
    it "can create a new Application" do
      visit "/applications/new"

      expect(page).to have_content("New Pet")
      expect(find("form")).to have_content("Name")
      expect(find("form")).to have_content("Street Address")
      expect(find("form")).to have_content("City")
      expect(find("form")).to have_content("State")
      expect(find("form")).to have_content("Zip Code")
      expect(find("form")).to have_content("Description of why I would make a good home")

      within "#applicant_form" do
      fill_in "Name", with: "Chee"
      fill_in "Street Address", with: "123 street"
      fill_in "City", with: "New Orleans"
      fill_in "State", with: "Louisana"
      fill_in "Zip Code", with: "12345"
      fill_in "Description of why I would make a good home", with: "I will love that dog till I die"
      end
      click_button "Submit"

      expect(page).to have_current_path("/applications/#{Application.last.id}")
      expect(page).to have_content("Name: Chee")
    end

    it "shows error when I fail to fill any form field" do
      visit "/applications/new"

      within "#applicant_form" do
      fill_in "Name", with: "Chee"
      end
      click_button "Submit"

      expect(page).to have_current_path("/applications/new")
      expect(page).to have_content("You must fill in all fields")
    end
  end
end