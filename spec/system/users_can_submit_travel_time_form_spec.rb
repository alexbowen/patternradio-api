require "rails_helper"

RSpec.describe "A user submitting the travel time form" do
  scenario "a user can submit the travel time form" do
    visit root_path

    click_on "Go!"

    expect(current_path).to eq(new_journey_path)

    fill_in "Address", with: "E3 3AA"
    choose id: "journey_form_transportation_type_public_transport"
    fill_in "Travel time", with: "30"
    click_on "Go"

    expect(current_path).to eq(journey_path)
  end
end
