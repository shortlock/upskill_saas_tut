class UsersController < ApplicationController
  before_action :select_user, :is_logged_in? , only: :show
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id])
    @profile = Profile.where(user_id: params[:id])
  end
  
  def index
    @user = User.all
    @profile = Profile.all
  end
  private
  def select_user
    unless Profile.where(user_id: params[:id]).exists?
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