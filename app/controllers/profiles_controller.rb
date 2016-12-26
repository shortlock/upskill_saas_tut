class ProfilesController < ApplicationController
  before_action :only_yours, except: :destroy
  
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile form
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path(params[:user_id])
    else
      flash[:error] = "Please complete all fields"
      render action: :new
    end
  end
  
  # Get requests made to /users/:user_id/profile/edit
  def edit
      @user = User.find( params[:user_id] )
      @profile = @user.profile
  end
  
  # PUT/PATCH reuest to /users/:user_id/profile
  def update
    # Retrieve user from database
    @user = User.find( params[:user_id] )
    # Retrieve that user's profile
    @profile = @user.profile
    # Mass assigned editied profile and saved(updated)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated!"
      # Redirects user to their profile page
      redirect_to user_path(params[:user_id])
    else
      render action :edit
    end
  end
  
  def destroy
    Profile.find(params[:id]).destroy
    flash[:success] = "Profile deleted"
    redirect_to admin_path
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_yours
      if User.exists?(:id => params[:user_id])
      @user = User.find(params[:user_id])
      unless current_user == @user || current_user.admin?
        flash[:danger] = "Cannot edit someone elses profile!"
        redirect_to root_url
      end
      else
        flash[:warning] = "User or Profile doesn't exist."
        redirect_to root_url
      end
    end
end