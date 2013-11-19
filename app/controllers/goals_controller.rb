class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.create(goal_params)
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
