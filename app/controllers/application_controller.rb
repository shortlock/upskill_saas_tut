class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #whitelist the following form fields so we can process them if coming from 
  #devise sign up form
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:home, :about]


  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation)}
    end
    
end
