class AdminsController < ApplicationController
  before_action :is_admin?

  
  def index
    @user = User.all
    @profile = Profile.all
    @contact = Contact.all
  end
  
  private
  
    def is_admin?
      unless current_user.admin?
        flash[:warning] = "Only for admins!"
        redirect_to root_path
      end
    end
    
end