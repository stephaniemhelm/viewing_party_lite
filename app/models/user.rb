class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, require: true
  validates_presence_of :password_confirmation, require: true
  has_many :user_parties
  has_many :parties, through: :user_parties

  has_secure_password
end
