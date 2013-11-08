require 'spec_helper'

describe "StaticPages" do

  it "should load the home page" do
    get root_path
    response.status.should be(200)
  end

  describe "#home" do

    before { visit root_path }

    subject { page }

    it { should have_title('Better Together') }
    it { should have_link('Save Goal') }
    it { should have_button('Sign in') }
    it { should have_button('Set Goal') }

    describe "with valid information for setting goal" do
     it { should fill_in "Goal", with: "I want to make 300 recipes in 365 days" }
    end
  end

end