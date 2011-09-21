class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to user_sites_path(@user), :notice => "Logged in!"
    else
      flash.now.alert = 'Email or password invalid.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, :notice => 'Successfully logged out'
  end
end
