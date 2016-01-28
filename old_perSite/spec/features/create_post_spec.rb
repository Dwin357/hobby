require 'rails_helper'

RSpec.feature " creating a post" do

	scenario " allow a user to make a post" do
		visit new_post_path

		fill_in "Title", with: "This is a capybara title"
		fill_in "Body", with: "This is some more text that is what a giant rat said"
		click_on "post"

		expect(page).to have_content("This is a capybara title")
		expect(page).to have_content("This is some more text that is what a giant rat said")

	end
end	