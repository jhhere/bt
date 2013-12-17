class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    sign_in(User.create(guest: true)) unless user_signed_in?
    @goal = current_user.goals.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.html { redirect_to current_user, :flash => { success: 'Your goal has been added!'} }
        format.js { @current_goal = @goal }
      else
        flash.now[:error] = "That's not a friggin' goal!"
        format.html { render action: 'new' }
      end
    end
  end

  def destroy
    @goal = Goal.destroy(params[:id])
      respond_to do |format|
        format.html { redirect_to current_user }
        format.js { @current_goal = @goal }
      end
  end

  def index
  end

private

  def goal_params
    params.require(:goal).permit(:goal)
  end

end
