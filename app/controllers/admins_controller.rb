class AdminsController < ApplicationController
  before_action :is_admin?

  
  def index
    @user = User.all
    @profile = Profile.all
    @contact = Contact.all
  end
  
  def destroy_contact
    @contact = Contact.find(params[:id]).destroy
    flash[:success] = "Contact entry deleted."
    redirect_to admin_path
  end
  
  private
  
    def is_admin?
      unless current_user.admin?
        flash[:warning] = "Only for admins!"
        redirect_to root_path
      end
    end
    
end