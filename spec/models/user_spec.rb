require 'spec_helper'

describe User do
  before { @user = User.new(email: "example@example.com", password: "password", password_confirmation: "password") }

  subject { @user }

  it { should be_valid }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:encrypted_password) }
  it { should respond_to(:reset_password_token) }
  it { should respond_to(:goals) }

  describe "with blank password" do
    before { @user.password = " "}
    it { should_not be_valid }
  end

  describe "with mismatched password" do
    before { @user.password_confirmation = " password1 " }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 7 }
    it { should be_invalid }
  end

  describe "guest user" do
    before { @user.email = "", @user.guest = true }
    it { should be_valid }
  end

  describe '#password_required?' do
    it "is true for non-guest users" do
      expect(@user.password_required?).to be_true
    end

    it "is false for saved non-guest users" do
      @user.save
      expect(@user.password_required?).to be_true
    end

    it "is false for guest users" do
      @user.guest = true
      expect(@user.password_required?).to be_false
    end
  end

  describe '#email_required?' do
    it "is true for non-guest users" do
      expect(@user.email_required?).to be_true
    end

    it "is true for saved non-guest users" do
      @user.save
      expect(@user.email_required?).to be_true
    end

    it "is false for guest users" do
      @user.guest = true
      expect(@user.email_required?).to be_false
    end
  end

  describe "with blank email" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email is too long" do
    before { @user.email = "a" * 51 }
    it { should_not be_valid }
  end

  describe "email" do
    it "valid format" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "saves as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "goal associations" do
    before { @user.save }
    let!(:goal) do
      FactoryGirl.create(:goal, user: @user, goal: "I want to eat every day")
    end

    it "have a goal" do
      expect(@user.goals.to_a).to eq [goal]
    end

    it "destroys associated goals" do
      goals = @user.goals.to_a
      @user.destroy
      expect(goals).not_to be_empty
      goals.each do |goal|
        expect(Goal.where(id: goal.id)).to be_empty
      end
    end
  end

end
