class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      redirect_to new_user_site_path(@user), :notice => 'Signed up!'
    else
      render 'new'
    end
  end
end
