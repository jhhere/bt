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

    within("#new_goal") do
      fill_in "goal_goal", with: "I will drink water"
      click_button set_goal
    end

    expect(page).to have_content("I want to sleep")
    expect(page).to have_content("I will drink water")
    expect("I want to sleep").to appear_before("I will drink water")

    visit current_url
    page.find("li.goal:first-child button.down").click
    expect("I will drink water").to appear_before("I want to sleep")

    page.find("li.goal:last-child button.up").click
    expect("I want to sleep").to appear_before("I will drink water")

  end

end