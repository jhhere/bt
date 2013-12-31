require 'spec_helper'

#Create Goals, then sign up
#does users#create create a user?
# does users#new show the new user form?"

describe "homepage" do

  before { visit root_path }

  let(:submit_goal) { "Set Goal" }

  it "goal creation fails with invalid information" do

    expect { click_button submit_goal }.not_to change(Goal, :count)

    page.should have_title('Better Together')
    page.should have_selector('#error_explanation', text: 'The form contains 1 error')
    page.should_not have_title('Your Profile')

    click_link "Better Together"
    page.should_not have_selector('.alert-error')
  end

  describe "goal creation" do
    before do
      fill_in "goal_goal", with: "I want to make 300 recipes in 365 days "
    end

    it "succeeds with valid information" do
      expect { click_button submit_goal }.to change(Goal, :count).by(1)
      page.should have_selector('.alert-success', text: 'Your goal has been added!')
      page.should have_title('Your Profile')
      page.should have_link('Sign out')
      page.should have_content('Your Goals')
    end
  end
end