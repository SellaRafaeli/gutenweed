$forum_threads = $mongo.collection('threads')
$forum_msgs    = $mongo.collection('forums')

post '/forums/new_thread' do 
	require_user
	title = pr[:title] 
	halt unless title.present? 
	$forum_threads.add(title: title, user_id: cuid)
	flash.message = 'Thanks!'
	redirect back
end

post '/forums/new_msg' do 
	require_user
	msg       = pr[:text] 
	thread_id = pr[:thread_id]
	halt unless msg.present? && thread_id.present? 
	$forum_msgs.add(thread_id: thread_id, msg: msg, user_id: cuid)
	flash.message = 'Thanks!'
	redirect back
end