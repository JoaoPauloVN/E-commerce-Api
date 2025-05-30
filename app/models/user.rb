class User < ApplicationRecord
	extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true
  validates :profile, presence: true

  enum :profile, admin: 0, client: 1
	
  include NameSearchable
  include Paginatable
end
