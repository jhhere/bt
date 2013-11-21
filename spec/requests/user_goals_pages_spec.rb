require 'spec_helper'

# Sign up then create goals
#does users#create create a user?
# does users#new show the new user form?"

describe "On homepage" do

  subject { page }

  before do
    visit root_path
  end

  it { should have_title('Better Together') }
  it { should have_link('Save Goal') }
  it { should have_link('Sign in', href: signin_path) }
  it { should have_field('goal_goal') }
  it { should have_button('Set Goal') }

  it { should_not have_link("Sign out") }

  describe "User goes to sign up own account" do
    before { visit signup_path }

    it { should have_selector('h2', text: 'Sign up') }
    it { should have_title('Sign up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my account" }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button "Create my account" }

        it { should have_title("Sign up") }
        it { should have_selector('.alert', text: 'Please review the problems below') }
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email", with: "example@example.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
      end

      it "should create a user" do
        expect { click_button "Create my account" }.to change(User, :count)
      end

      describe "after saving the user" do
        before { click_button "Create my account" }

        it { should have_selector('.alert', text: 'Welcome! You have signed up successfully.') }
        it { should have_title('Better Together') }
        it { should have_link('Your Profile') }
        it { should have_link('Sign out') }
        it { should_not have_link('Sign in') }
      end

        describe "the user creates a goal" do

          describe "with invalid information" do

            it "should not create a goal" do
              expect { find('input[type=submit]').click }.not_to change(Goal, :count)
            end

            describe "after submission" do
              before { find('input[type=submit]').click }

              it { should have_title('Better Together') }
              it { should_not have_title('Your Profile') }

              it { should have_selector('#error_explanation', text: 'The form contains 1 error') }
            end

          end
        end
    end
  end
end


