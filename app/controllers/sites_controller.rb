class SitesController < ApplicationController
  def index
    @sites = Site.all
  end

  def new
    @user = User.find(params[:user_id])
    @site = @user.sites.build
  end

  def create
    @site = Site.create(params[:site])
    @user = @site.user
    if @user && @site.save 
      redirect_to user_sites_path @site.user
    else
      render 'new'
    end
  end
end
