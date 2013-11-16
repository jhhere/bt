require 'spec_helper'

describe "SessionsPages" do

  subject { page }

  describe "create goal on homepage" do
    before { visit root_path }

    it { should have_title('Better Together') }
    it { should have_link('Save Goal') }
    it { should have_button('Sign in') }
    it { should have_button('Set Goal') }

    describe "with invalid information" do
      before { click_button "Set Goal" }

      it { should have_title('Better Together') }
      it { should have_selector('div.alert.alert-error', text: 'friggin') }

      describe "after visiting another page" do
        before { click_link "Better Together" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information" do
      let(:goal) { FactoryGirl.create(:goal) }
      before do
        fill_in "session_goal", with: "I want to make 300 recipes in 365 days"
        click_button "Set Goal"
      end

      it { should have_title('Goals') }
      it { should have_selector('h1', 'Your Goals') }
    end
  end
end
