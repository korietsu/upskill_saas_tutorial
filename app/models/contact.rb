class Contact < ActiveRecord::Base
    #Form Validations for each field. 
    validates :name, presence: true
    validates :email, presence: true
    validates :comments, presence: true
end