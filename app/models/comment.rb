class Comment < ActiveRecord::Base
	has_many :votes, dependent: :destroy
	belongs_to :post
	belongs_to :user
	validates :content, presence: true

	def votes_total
		total = self.votes.map { |vote| vote.number }.reduce(:+)
		total.nil? ? 0 : total
	end

end