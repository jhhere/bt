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
        it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email", with: "example@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirm Password", with: "password"
      end

      it "should create a user" do
        expect { click_button "Create my account" }.to change(User, :count)
      end

      describe "after saving the user" do
        before { click_button "Create my account" }

        let(:user) { User.find_by(email: "example@example.com") }

        it { should have_title("Your Profile") }
        it { should have_content(user.email) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.email) }
    it { should have_title("Your Profile") }
  end
end
