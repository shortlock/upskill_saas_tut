class Profile < ActiveRecord::Base
  belongs_to :user
  
  # Profile form validations
  validates :first_name, presence: true
  validates :first_name, presence: true
  validates :phone_number, presence: true
  validates :contact_email, presence: true
  validates :description, presence: true
end