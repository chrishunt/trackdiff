class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      redirect_to new_user_site_path(@user), :notice => "Logged in!"
    else
      flash.now.alert = 'Email or password invalid.'
      render 'new'
    end
  end
end
