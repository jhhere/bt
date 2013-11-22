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

    let(:signup_submit) { "Create my account"}

    it { should have_selector('h2', text: 'Sign up') }
    it { should have_title('Sign up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button signup_submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button signup_submit }

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
        expect { click_button signup_submit }.to change(User, :count)
      end

      describe "after saving the user" do
        before { click_button signup_submit }

        it { should have_selector('.alert', text: 'Welcome! You have signed up successfully.') }
        it { should have_title('Better Together') }
        it { should have_link('Your Profile') }
        it { should have_link('Sign out') }
        it { should_not have_link('Sign in') }
      end

        describe "The user creates a goal" do
          before do
            visit root_path
          end

          let(:submit_goal) { "Set Goal" }

          describe "with invalid information" do

            it "should not create a goal" do
              expect { click_button submit_goal }.not_to change(Goal, :count)
            end

            describe "after submission" do
              before { click_button submit_goal }

              it { should have_title('Better Together') }
              it { should have_content("That's not a friggin' goal") }
              it { should have_selector('#error_explanation', text: 'The form contains 1 error') }

              it { should_not have_title('Your Profile') }

              describe "visiting another page should not display flash message" do
                before { click_link "Better Together" }
                it { should_not have_selector('.alert-error') }
              end
            end

          end

          describe "with valid information" do
            before do
              fill_in "goal_goal", with: "I want to make 300 recipes in 365 days"
            end

            it "should create a goal" do
              expect { click_button submit_goal }.to change(Goal, :count).by(1)
            end

            describe "after creating a goal" do
              before { click_button submit_goal }

              it { should have_selector('.alert-success', text: 'Goal created!') }
              it { should have_title('Your Profile') }
              it { should have_link('Sign out') }

              it { should_not have_link('Sign in') }

              describe "displays on profile page" do
                let(:user) { FactoryGirl.create(:user) }
                let!(:goal_1) { FactoryGirl.create(:goal, user: user, goal: "I want to make 300 recipes in 365 days") }

                before do
                  visit user_path(user)
                end

                it { should have_content('Your Goals') }
                it { should have_content(user.email)}
              end
            end
          end
        end
    end
  end
end


