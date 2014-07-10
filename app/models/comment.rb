class Comment < ActiveRecord::Base
	has_many :votes, dependent: :destroy
	belongs_to :post
	belongs_to :user
	validates :content, presence: true
end