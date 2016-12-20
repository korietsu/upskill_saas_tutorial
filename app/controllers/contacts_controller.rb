class ContactsController < ApplicationController
 
  #GET Request to /contact-us Instantiates new contact form. 
  def new
    @contact = Contact.new
  end
  
  #POST request to /contacts to create new record. 
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      #Mass assignment of form fields into contact object. Save contact object to DB, mail to site administrator. 
      flash[:success] = "Message Sent."
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      ContactMailer.contact_email(name, email, body).deliver
       redirect_to new_contact_path
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end
  end
  
  
  private
  #Whitelist form fields when collecting form data as security feature. 
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
    
end