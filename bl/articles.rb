get '/articles' do
	erb :'other/articles', default_layout
end

get '/articles/:title' do
	erb :"articles/#{pr[:title]}", default_layout
end
