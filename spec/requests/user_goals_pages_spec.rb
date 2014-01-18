require 'spec_helper'

describe "homepage" do
  before { visit root_path }

  it "shows goal form and guest user links" do
    page.should have_title('Better Together')
    page.should have_link('Save Goal')
    page.should have_link('Sign in', href: signin_path)
    page.should have_field('goal_goal')
    page.should have_button('Set Goal')
    page.should_not have_link("Sign out")
  end
end

describe "sign up" do
  let(:signup_submit) { "Create my account" }

  before do
    visit signup_path
    page.should have_selector('h2', text: 'Sign up')
    page.should have_title('Sign up')
  end

  it "fails with invalid information" do
    expect { click_button signup_submit }.not_to change(User, :count)
    page.should have_title("Sign up")
    page.should have_selector('.alert', text: 'Please review the problems below')
  end

  it "succeeds with valid information" do
    fill_in "Email", with: "example@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"

    expect { click_button signup_submit }.to change(User, :count)

    page.should have_selector('.alert', text: 'Welcome! You have signed up successfully.')
    page.should have_title('Better Together')
    page.should have_link('Your Profile')
    page.should have_link('Sign out')
    page.should_not have_link('Sign in')

    click_link 'Sign out'
    click_link 'Sign in'

    fill_in "Email", with: "example@example.com"
    fill_in "user_password", with: "password"

    click_button 'Sign in'
    page.should have_selector('.alert-notice', text: 'Signed in successfully.')
  end
end

describe "goal creation" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:goal_1) { FactoryGirl.create(:goal, user: user, goal: "I want to make 300 recipes in 365 days") }
  let!(:goal_2) { FactoryGirl.create(:goal, user: user, goal: "I want to read a book in 7 days") }
  let(:submit_goal) { "Set Goal" }

  before { visit root_path }

  it " fails with invalid information" do

    expect { click_button submit_goal }.not_to change(Goal, :count)

    page.should have_title('Better Together')
    page.should have_selector('#error_explanation', text: 'The form contains 1 error')
    page.should_not have_title('Your Profile')

    click_link "Better Together"
    page.should_not have_selector('.alert-error')
  end

  describe "succeeds" do
    before do
      fill_in "goal_goal", with: "I want to make 300 recipes in 365 days"
    end

    it "with valid information" do
      expect { click_button submit_goal }.to change(Goal, :count).by(1)

      page.should have_selector('.alert-success', text: 'Goal created!')
      page.should have_title('Your Profile')
      page.should have_link('Sign out')
      page.should_not have_link('Sign in')

      visit user_path(user)
      page.should have_content('Your Profile')
      page.should have_content(goal_1.goal)
      page.should have_content(goal_2.goal)
    end
  end
end