get '/articles/:article_id' do 
	# erb :"/articles/#{pr[:id]}", default_layout
	erb :'search/search', default_layout
end