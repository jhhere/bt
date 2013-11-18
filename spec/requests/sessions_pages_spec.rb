require 'spec_helper'

describe "SessionsPages" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') }
    it { should have_title('Sign in') }

    describe "with invalid information" do
      before { click_button "Sign in!"}

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error', text: 'Please fill out correct email/password combo.')}

    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in!"
      end

      it { should have_title('Your Profile') }
      it { should have_link('Sign out', href: signout_path) }

      describe "followed by signout" do
        before { click_link 'Sign out' }
        it { should have_link('Sign in') }
      end
    end
  end
end
