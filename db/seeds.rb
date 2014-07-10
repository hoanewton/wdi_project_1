
Post.destroy_all
User.destroy_all

admin = User.create!(
	username: "admin",
	first_name: "Hoa",
	last_name: "Newton",
	password: "123"
	)

url = 'http://api.nytimes.com/svc/search/v2/articlesearch.json?fq=source:("The New York Times")&api-key=84fccf8f4af9a0e6bf8794d10b603032:15:69557943'
response = HTTParty.get(URI.escape(url))
articles = response['response']['docs']

articles.each do |article|
	if article['headline']['print_headline'].nil? || article['headline']['print_headline'] == ""
		escaped_title = "Unknown"
	else
		escaped_title = article['headline']['print_headline']
	end

	if !(article['lead_paragraph'].nil?) && !(article['lead_paragraph'] == "")
		Post.create!(
			title: escaped_title,
			content: article['lead_paragraph'],
			user_id: admin.id
			)
	end
end

