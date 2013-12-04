require 'spec_helper'

describe "Sign in via Twitter" do
  #let!(:user) { create(:user, :with_google_account) }

  before do
    visit root_path

    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '1337',
      :info => {
        :email => 'test@some_test_domain.com',
        :name=>'Test User'
      }
    })
  end

  it "when user clicks login" do
    click_link 'Sign in with Twitter'

    page.should have_content('from Twitter account.')
    page.should have_link('Sign out')
  end
end