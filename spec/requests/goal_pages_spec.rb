require 'spec_helper'

describe "Goal Pages" do

  subject { page }

  describe "homepage to create goal" do
    before do
      visit root_path
    end

    it { should have_title('Better Together') }
    it { should have_link('Save Goal') }
    it { should have_link('Sign in') }
    it { should have_button('Set Goal') }

    let(:submit) { "Set Goal" }

    describe "with invalid information for setting goal" do

      it "should not create a goal" do
        expect { click_button submit }.not_to change(Goal, :count)
      end

      before { click_button('Set Goal') }

      it { should have_title('Better Together') }
      it { should have_selector('div.alert.alert-error', text: 'friggin') }

      describe "after visiting another page should not display flash" do
        before { click_link "Better Together" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid information for setting goal" do
      let(:goal) { FactoryGirl.create(:goal) }
      before do
        fill_in "goal_goal", with: "I want to make 300 recipes in 365 days"
      end

      it "should create a goal" do
        expect { click_button submit }.to change(Goal, :count).by(1)
      end
    end
  end
end
