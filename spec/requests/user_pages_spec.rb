require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title('Sign up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button "Create my account" }

        it { should have_title("Sign up") }
        it { should have_content('Please review the problems below') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email", with: "example@example.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
      end

      it "should create a user" do
        expect { click_button "Create my account" }.to change(User, :count)
      end

      describe "after saving the user" do
        before { click_button "Create my account" }

        let(:user) { User.find_by(email: "example@example.com") }

        #it { should have_title('Your Profile') }
        it { should have_link('Sign out') }
        #it { should have_content(user.email) }
        #it { should have_selector('div.alert.alert-success', text: 'success') }
      end
    end
  end

=begin
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:goal_1) { FactoryGirl.create(:goal, user: user, goal: "I want to make 300 recipes in 365 days") }
    let!(:goal_2) { FactoryGirl.create(:goal, user: user, goal: "I will read a book in a week") }

    before { visit user_path(user) }

    it { should have_title("Your Profile") }

    describe "goals list" do
      it { should have_content(goal_1.goal) }
      it { should have_content(goal_2.goal) }
      it { should have_content(user.goals.count) }
    end
  end
=end
end
