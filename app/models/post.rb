class Post < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, :content, :user, presence: true

	def self.autogenerate
		url = 'http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=source:("The New York Times")&api-key=84fccf8f4af9a0e6bf8794d10b603032:15:69557943'
		response = HTTParty.get(URI.escape(url))
		articles = response['response']['docs']
		raw_article = articles.sample
		article = {}
		article[:title] = raw_article['headline']['print_headline']
		article[:content] = raw_article['lead_paragraph']
		article
	end

end