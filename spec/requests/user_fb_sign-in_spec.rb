require 'spec_helper'

describe "Sign in with Facebook" do

  before do
    visit root_path

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '1337',
      :info => {
        :email => 'test@some_test_domain.com',
      },
      :extra => {
        :raw_info => {
          :name => 'Test User'
        }
      }
    })
  end

  it "when user clicks login" do
    click_link 'Sign in with Facebook'

    page.should have_content('from Facebook account.')
    page.should have_link('Sign out')
  end
end