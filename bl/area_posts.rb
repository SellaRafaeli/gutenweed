$area_posts = $mongo.collection('area_posts')

post '/area_posts/submit' do 
	if !cu 
		flash.message = 'Sign up first.'
		redirect '/signup' 
	end

	data = {user_id: cuid, handle: cu[:handle], text: pr[:text], city: pr[:city], state: pr[:state]}
	$area_posts.add(data)
	flash.message = 'Thanks'
	redirect back
end