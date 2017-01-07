class Users::RegistrationsController < Devise::RegistrationsController
  before_action :select_plan, only: :new
  before_action :check_captcha, only: [:create]

  #extend default devise gem behaviour so that
  #users signing up with  the pro account(Plan Id 2)
  #save with a special stripe subsciption function
  # otherwise devise signs up user as usual
  def create
    super do |resource|
        if params[:plan]
          resource.plan_id = params[:plan]
          if resource.plan_id == 2
            resource.save_with_subscription
          else
            resource.save
          end
        end  
    end
  end
  
  private
  def select_plan
    unless (params[:plan] == '1' || params[:plan] == '2')
      flash[:notice] = "Please select a membership plan to sign up."
      redirect_to root_url
    end
  end
  
  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      respond_with_navigational(resource) { render :new }
    end 
  end
end
