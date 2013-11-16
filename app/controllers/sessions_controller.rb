class SessionsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(session_params)
    if @goal.save
      flash[:success] = "Goal created!"
      redirect_to @goal
    else
      flash.now[:error] = "That's not a friggin' goal!"
      render 'new'
    end
  end

  private

    def session_params
      params.require(:session).permit(:goal)
    end
end
