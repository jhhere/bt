require 'spec_helper'

describe Users::OmniauthCallbacksController do

  describe "Google Oauth2" do
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

    it "signs user in and redirect to homepage" do
      get :google_oauth2
      flash[:notice].should match /#{I18n.t "devise.omniauth_callbacks.success", :kind => "Google"}/
      response.should redirect_to root_path
    end
  end

  describe "Facebook" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]

      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        :provider => 'facebook',
        :uid => '1337',
        :info => {
          :email => 'test@some_twitter_domain.com',
        },
        :extra => {
          :raw_info => {
            :name => 'Test Facebook User'
          }
        }
      })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]

    end

    it "signs user in and redirect to homepage" do
      get :facebook
      flash[:notice].should match /#{I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"}/
      response.should redirect_to root_path
    end
  end

  describe "Twitter" do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]

      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        :provider => 'twitter',
        :uid => '1337',
        :info => {
          :email => 'test@some_twitter_domain.com',
          :name => 'Test Twitter User'
        }
      })

      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter]
    end

    it "signs user in and redirect to homepage" do
      get :twitter
      flash[:notice].should match /#{I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"}/
      response.should redirect_to root_path
    end
  end
end