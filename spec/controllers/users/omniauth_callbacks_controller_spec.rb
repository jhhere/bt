require 'spec_helper'

describe Users::OmniauthCallbacksController do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '1337',
      :info => {
        :email => 'test@some_test_domain.com',
        :name=>'Test User'
      }
    })

    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]

  end

  it "Google Oauth2" do
    get :google_oauth2
    flash[:notice].should match /#{I18n.t "devise.omniauth_callbacks.success", :kind => "Google"}/
    response.should redirect_to root_path
  end
end