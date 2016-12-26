class ContactsController < ApplicationController
    skip_before_filter :authenticate_user!
    #GET request to /contact-us
    #Show new contact form
    def new
        @contact = Contact.new
    end
    
    #POST request /contacts
    def create
        # Mass assignment of form fields into contact object
        @contact = Contact.new(contact_params)
        # Save the contact object to database
        if @contact.save
            # Store form fileds via parameters, into variables
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug variables into contact mailer
            # email methond and send email
            ContactMailer.contact_email(name, email, body).deliver
            # Store success message in flash hash
            # and redirect to the new action
            flash[:success] = "Message Sent"
            redirect_to new_contact_path
        else
            # If contact object doesn't save,
            # store errors in flash hash
            # and redirect to the new action
            flash[:danger] = @contact.errors.full_messages.join(", ")
            render action :new
        end
    end

    private
        # To collect data from from we need to use 
        # strong parameters and whitelist form fields
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end