require 'spec_helper'

describe Goal do
  before do
    @goal = Goal.new(goal: "I want to make 300 recipes in 365 days")
  end

  subject { @goal }

  it { should respond_to(:goal) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  describe "remember token" do
    before { @goal.save }
    its(:remember_token) { should_not be_blank }
  end

  describe "when goal is not present" do
    before do
      @goal = Goal.new(goal: " ")
    end

    it { should_not be_valid }
  end
end
