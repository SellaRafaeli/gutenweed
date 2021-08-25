def get_articles_list
	articles = Dir['./views/articles/*'].sort
	res = articles.map {|path|
		name = path[17..path.size-5]
    link = path[8..path.size-5]
    {name: name, link: link}
	}
	return res
end

get '/articles' do
	erb :'other/articles', default_layout
end

get '/articles/:title' do
	html          = erb :"articles/#{pr[:title]}"
	erb :"other/article_container", default_layout.merge(locals: {html: html})
end
