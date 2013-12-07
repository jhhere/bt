require 'spec_helper'

describe Users::InvitationsController do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.new(email: "example@example.com", password: "password", password_confirmation: "password")
    sign_in @user
  end

  describe 'create action' do
    it "sends an invite email" do
      expect{ post :create, :email => "friend_email@example.com" }.to change(ActionMailer::Base.deliveries, :size)
    end
  end

end