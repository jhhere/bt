require 'spec_helper'

describe Users::InvitationsController do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'create action' do
    it "sends an invite email" do
      expect{ post :create, :email => "friend_email@example.com" }.to change(ActionMailer::Base.deliveries, :size)
    end
  end

end