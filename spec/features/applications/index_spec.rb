require "rails_helper"

describe "Application Index" do
  describe "As a Vistior" do
    it "has a link to 'Start an Application" do
      visit "/application"

      expect(page).to have_link("Start an Application")
    end
  end
end