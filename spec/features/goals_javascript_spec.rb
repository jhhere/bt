require 'spec_helper'

describe "run with webkit" do
  # let(:user) { FactoryGirl.create(:user) }

  it "has no javascript errors on the homepage", js: true do
    visit root_path
    expect(page).not_to have_errors
  end



end