class User < ApplicationRecord
  include Roles

  has_one :invitation, foreign_key: :email, primary_key: :email

  define_roles :developer, :owner, :admin

  # WARNING: Enabling registerable will allow users to sign up for the
  # application on their own.  This raises security requirements for the app.
  # We prefer to use a invitation sign up model where administrators invite
  # all new users to the application (This is enabled by the default app). 
  #
  # HERE BE DRAGONS.

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable
  def name
    "#{first_name} #{last_name}"
  end
end
