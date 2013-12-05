require 'spec_helper'

describe UsersController do
  assert_difference('ActionMailer::Base.deliveries.size', 1) do
    get :invite_friend, :email => 'friend_email@example.com'
  end
end