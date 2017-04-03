class User < ApplicationRecord
  include Roles

  has_one :invitation, foreign_key: :email, primary_key: :email

  define_roles :developer, :owner, :admin

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable,
         :validatable
  def name
    "#{first_name} #{last_name}"
  end
end
