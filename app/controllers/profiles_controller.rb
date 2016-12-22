class ProfilesController < ApplicationController
  before_action :only_yours, only: :edit
  
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
    @user = User.find(params[:user_id])
    @profile = @user.profile
  end
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_yours
      @user = User.find(params[:user_id])
      if current_user.id != (@user.id)
        flash[:notice] = "Cannot edit someone elses profile!"
        redirect_to root_url
      end
    end
end