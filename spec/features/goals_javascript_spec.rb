require 'spec_helper'

describe "run with webkit" do

  it "has no javascript errors on the homepage", js: true do
    visit root_path
    expect(page).not_to have_errors
  end


let(:set_goal) { "Set Goal" }

  it "can reorder goals using sortable", js:true do
    visit root_path
    within("#new_goal") do
      fill_in "goal_goal", with: "I want to sleep"
      click_button set_goal
    end

    expect(page).to have_content("I want to sleep")

  end

end