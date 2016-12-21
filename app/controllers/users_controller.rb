class UsersController < ApplicationController
  before_action :select_user ,:is_logged_in?
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id])
    @profile = Profile.where(user_id: params[:id])
    @date = User.find( params[:id]).created_at.strftime("%B %d, %Y ")
  end
  
  def index
    @user = User.all
    @profile = Profile.all
  end
  private
  def select_user
    unless Profile.where(user_id: params[:id]).exists? || params[:action] == "index"
      flash[:notice] = "User or profile does not exist."
      redirect_to root_url
    end
  def is_logged_in?
    unless user_signed_in?
      flash[:notice] = "Please log in to view profiles."
      redirect_to root_url
    end
  end
  end
end