class SitesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if @user && current_user == @user
      @sites = @user.sites
    elsif current_user
      redirect_to user_sites_path(current_user),
        :notice => "You can't access other user's sites"
    else
      redirect_to login_path, :notice => "You must login."
    end
  end

  def new
    @user = User.find(params[:user_id])
    if @user && current_user == @user
      @site = @user.sites.build
    elsif current_user
      redirect_to new_user_site_path(current_user)
    else
      redirect_to login_path,
        :notice => "You must login."
    end
  end

  def create
    @site = Site.create(params[:site])
    @user = @site.user
    if @user && current_user == @user && @site.save
      redirect_to user_sites_path(@site.user)
    else
      render 'new'
    end
  end
end
