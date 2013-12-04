require 'spec_helper'

describe "email invitation" do
  let(:user) { FactoryGirl.create(:user) }
  let(:invitation_submit) { "Send an invitation"}

  before do
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button 'Sign in'
    visit user_path(user)
  end

  it "link on user profile page" do
    page.should have_title('Your Profile')
    page.should have_link('Invite Your Friend')
  end

  describe "to friend" do

    before do
      click_link 'Invite Your Friend'
    end

    it "succeeds" do
      page.should have_content('Send invitation')

      fill_in "Email", with: "friend_email@example.com"
      click_button invitation_submit
      page.should have_selector('.alert-notice', text: 'An invitation email has been sent to friend_email@example.com')
    end

    it "fails with no email" do
      fill_in "Email", with: ""
      click_button invitation_submit
      page.should have_content("Email can't be blank")
    end
  end

end