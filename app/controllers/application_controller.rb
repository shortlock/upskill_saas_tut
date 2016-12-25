class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #whitelist the following form fields so we can process them if coming from 
  #devise sign up form
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :is_admin?, only: :admin


  before_action :authenticate_user!, except: :home

  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation)}
    end
    
    def is_admin?
      unless 1==2
        flash[:danger] = "Only for admins!"
        redirect_to root_path
      end
    end
    
end
