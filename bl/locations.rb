$locations = $mongo.collection('locations')

post '/locations' do
	new_loc = {user_id: cuid, name: 'New Location'} #, type: 'Store', address: '123 Main Street'}
	$locations.add(new_loc)
	flash.message = 'Added.'
	redirect back
end

get '/locations/:id' do
	loc = $locations.get(pr[:id])
	halt unless loc[:user_id] == cuid

	erb :'locations/single_location', default_layout.merge(locals: {loc: loc})
end

post '/locations/:id' do 
	loc = $locations.get(pr[:id])
	halt unless loc[:user_id] == cuid

	$locations.update_id(pr[:id], pr)
	flash.message = 'Updated Location.'
	redirect back;
end