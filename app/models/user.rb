class User < ActiveRecord::Base
	has_secure_password
	has_many :comments , dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :posts, dependent: :destroy


	validates :username, :first_name, presence: true
	validates :username, uniqueness: true
end