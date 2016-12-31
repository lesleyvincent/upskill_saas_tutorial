class ContactsController < ApplicationController
    
    # Get request to /contact-us
    # Show new contact form 
   def new
       @contact = Contact.new
   end
   
   # POST request /contacts
   def create
      # Mass assignment of form feilds into contact object
      @contact = Contact.new(contact_params)
      # Save the contact object to the database 
      if @contact.save
         # Save form fields via parameters into variables 
         name = params[:contact][:name]
         email = params[:contact][:email]
         body = params[:contact][:comments]
         # Plug variables into the Contact Mailer 
         #Email method and send email
         ContactMailer.contact_email(name, email, body).deliver
         # Store success message in flash hash 
         # And redirect to new action
         flash[:success] = "Message Sent."
         redirect_to new_contact_path
      else
         # If contact object does not save
         # Store errors in flash hash
         # And redirect to the new action
         flash[:danger] = @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
   end
   
   private 
   # To collect data from form, we need to use 
   # strong parameters and whitelist the form fields
   def contact_params
      params.require(:contact).permit(:name,:email,:comments)
   end

end