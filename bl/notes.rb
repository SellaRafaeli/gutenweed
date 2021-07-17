$notes = $mongo.collection('notes')

post '/notes' do 
	data = pr
	data[:user_id] = cuid
	$notes.add(data)
	{msg: 'ok'}
end