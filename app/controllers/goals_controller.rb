class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    sign_in(User.create(guest: true)) unless user_signed_in?
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      flash[:success] = "Goal created!"
      redirect_to current_user
    else
      flash.now[:error] = "That's not a friggin' goal!"
      render 'new'
    end
  end

  def destroy
  end

private

  def goal_params
    params.require(:goal).permit(:goal)
  end

end
