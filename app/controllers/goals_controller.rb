class GoalsController < ApplicationController
  def new
    @goal = Goal.new
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      flash[:success] = "Goal created!"
      redirect_to @goal
    else
      flash.now[:error] = "That's not a friggin' goal!"
      render 'new'
    end
  end

  private

    def goal_params
      params.require(:goal).permit(:goal)
    end
end
