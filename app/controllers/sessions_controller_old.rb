class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Yay"
      sign_in user
      redirect_to user
    else
      flash.now[:error] = "Please fill out correct email/password combo."
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private

    def session_params
      params.require(:session).permit(:goal)
    end
end
