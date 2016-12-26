class UsersController < ApplicationController
  before_action :select_user, except: :destroy
  
  # GET to /users/:id
  def show
    @user = User.find( params[:id])
    @profile = Profile.where(user_id: params[:id])
    @date = User.find( params[:id]).created_at.strftime("%B %d, %Y ")
  end
  
  def index
    @user = User.includes(:profile)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
    
  private
  def select_user
    unless Profile.where(user_id: params[:id]).exists? || params[:action] == "index"
      flash[:notice] = "User or profile does not exist."
      redirect_to root_url
    end
  end
end