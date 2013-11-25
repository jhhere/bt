require 'spec_helper'

describe "Sign in via Google" do
  #let!(:user) { create(:user, :with_google_account) }

  before do
    visit root_path

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '1337',
      :info => {
        :email => 'test@some_test_domain.com',
        :name=>'Test User'
      }
    })
  end

  it "when user clicks login" do
    click_link 'Sign in with Google'

    page.should have_content('from Google account.')
    page.should have_link('Sign out')
  end
end