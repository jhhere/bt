require 'spec_helper'

describe GoalsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:goal) { FactoryGirl.create(:goal) }

  it "create a goal on the user profile page via ajax" do
    xhr :post, :create, goal: { goal: goal }
    expect(response).to be_success
  end

  it "create a goal increments the count" do
    expect do
      xhr :post, :create, goal: { goal: goal }
    end.to change(Goal, :count).by(2)
  end

end