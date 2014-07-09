class User < ActiveRecord::Base
	has_secure_password
	has_many :comments , dependent: :destroy
	has_many :votes, dependent: :destroy
	has_many :posts, dependent: :destroy

	validates_presence_of :username, :first_name
	validates :username, uniqueness: true
end