require 'spec_helper'

describe Goal do

  let(:user) { FactoryGirl.create(:user) }
  before { @goal = user.goals.new(goal: "I want to make 300 recipes in 365 days") }

  it "has a valid factory" do
    user.should be_valid
  end

  subject { @goal }

  it { should respond_to(:goal) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @goal.user_id = nil }

    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @goal.goal = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @goal.goal = "a" * 141 }
    it { should_not be_valid }
  end
end
