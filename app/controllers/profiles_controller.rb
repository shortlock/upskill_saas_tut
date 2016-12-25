class ProfilesController < ApplicationController
  before_action :only_yours
  
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
      @user = current_user
      @profile = @user.profile
  end
  
  # PUT/PATCH reuest to /users/:user_id/profile
  def update
    # Retrieve user from database
    @user = current_user
    # Retrieve that user's profile
    @profile = @user.profile
    # Mass assigned editied profile and saved(updated)
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile Updated!"
      # Redirects user to their profile page
      redirect_to user_path( current_user.id)
    else
      render action :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_yours
      if User.exists?(:id => params[:user_id])
       @user = User.find(params[:user_id])
      unless current_user == @user
        flash[:notice] = "Cannot edit someone elses profile!"
        redirect_to root_url
      end
      else
        flash[:notice] = "User or Profile doesn't exist."
        redirect_to root_url
      end
    end
end