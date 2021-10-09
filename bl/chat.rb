$chat = $mongo.collection('chat')

CHAT_CAST        = 'chat_cast'
CHAT_MSG_CLEARED = 'chat_msg_cleared'
CHAT_MSG_OK      = 'chat_msg_ok'

def cast_chat_channel(cast)
	"private-cast_chat_#{cast[:_id]}"
end

def silenced_key(user_id)
	"#{user_id}_silenced"
end

def is_chat_cast(cast)
	cast[CHAT_CAST]
end

def can_watch_chat_cast(cast)
	cast[:allowed_ids].to_a.include?(cuid)
end

def ensure_chat_exists(buyer_id, seller_id)
	id     = [buyer_id, seller_id].sort.join('_')+'_chat'
	buyer  = $users.get(buyer_id)
	seller = $users.get(seller_id)
	chat_allowed_ids = [buyer[:_id], seller[:_id]]
	handles          = [buyer[:handle], seller[:handle]]
	cast = $casts.update_id(id, {CHAT_CAST => true, allowed_ids: chat_allowed_ids, handles: handles}, {upsert: true})
end

def get_my_chats(user_id, opts = {})
	casts = $casts.get_many(CHAT_CAST => true, allowed_ids: user_id)

	if opts && opts[:last_msg_after]
		casts = casts.select {|cast|
			$chat.last(cast_id: cast[:_id])[:created_at] > opts[:last_msg_after]
		}
	end

	casts
end

def chat_cast_ouid(cast)
	(cast[:allowed_ids].to_a.without(cuid))[0]
end

def clear_cast_chat(cast, until_time)
	#$chat.update_many({cast_id: cast[:_id], created_at: {'$lt': Time.parse(until_time)}}, {'$set': {status: CHAT_MSG_CLEARED, cleared_at: Time.now}} )
	$chat.update_many({cast_id: cast[:_id]}, {'$set': {status: CHAT_MSG_CLEARED, cleared_at: Time.now}} )
end

get '/chat' do 
	require_user

	if pr[:ouid] && (user = $users.get(pr[:ouid]))
		ensure_chat_exists(cuid, user[:_id]) 
	end
		
	erb :'/chat/home', default_layout
end

def get_unread_chats_ouids(user_id, opts = {})
	chats = get_my_chats(user_id, opts)
	chats = chats.select {|chat| 
		key_one = "last_msg_for_#{user_id}"
		key_two = "#{user_id}_viewed_at"
		chat[key_one] > chat[key_two] rescue false
	}
	
	ouids = chats.map {|chat| chat_cast_ouid(chat) }
	ouids
end

get '/chat/open' do 
	ouids = get_unread_chats_ouids(cuid)
	
	{ouids: ouids}
end

get '/chat/:cast_id/all' do 
	cast = $casts.get(pr[:cast_id])
	halt(401, 'plz_login_first') unless cu
	
	erb :'/chat/chat_msgs', locals: {cast_id: pr[:cast_id], cast: cast}
end



post '/chat/send' do
	#optimistic_msg = {id: 'mock'+Time.now.to_s, user_id: cuid, img_url: cu[:img_url], type: cu[:type], name: cu[:name], msg: pr[:msg], created_at: Time.now}
	
	#html = erb :'chat/single_chat_msg', locals: {msg: optimistic_msg}
	
	# Thread.new {	
		my_id = cuid
		if !cu && (email = pr[:email]).present? #allow signup-on-first-msg by sending pr[:email]=...
			if $users.get(email: email)
				halt(200,{err: 'Email taken. Perhaps try to log in?', goto: "/login?email=#{email}&go_back_to=#{pr[:go_back_to]}"})
			else 
				add_user
				new_user = $users.get(email: email)
				session[:user_id] = my_id = new_user[:_id]
			end
		end

		if pr[:user_chat]
			cast = ensure_chat_exists(my_id, pr[:target_id])
		else 
			#cast = $casts.get(pr[:cast_id])
			id = pr[:cast_id]
			cast = {_id: id, zipcode: id}.hwia
		end

		user = $users.get(my_id)
			
		data = {cast_id: cast[:_id], 
			user_id: user[:_id], 
			name: user[:name] || user[:handle], 
			img_url: user[:img_url],
			type: user[:type], 
			message: pr[:msg], 
			status: CHAT_MSG_OK,
			#html: html
		}

		if cast[silenced_key(user[:_id])]
			# halt(401, {err: 'You have been silenced :('})
		end

		type = pr[:type] || 'new-msg'

		#if type == 'rtc-offer' || type == 'rtc-answer' || type == 'rtc-start' || type == 'rtc-ice-candidate'
		if type.to_s.include?('webrtc') || type == 'newHTML'
			data = data.merge(pr) #send the rtc-desc (offer/answer)
		else 
			$chat.add(data) 
		end

		if is_chat_cast(cast)
			other_user_id = chat_cast_ouid(cast)
			$casts.update_id(cast[:_id], "last_msg_for_#{other_user_id}" => Time.now)
		end
		
		data[:all_channels_last_day] = $all_channels_data

		Thread.new {
			$pusher.trigger(cast_chat_channel(cast), type, data)	
		}

		if pr[:redirect_back]
			flash.message = 'Thank you!'
			redirect back
		end

		{res: 'ok'}
	# }	

	#return {html: html}
end

$all_channels_data = {}
def update_all_channels_last_day
	res = {} 
	$chat.distinct(:cast_id).each {|v| res[v] = $chat.count(cast_id: v, created_at: {'$gt': 24.hours.ago}) }
	
	res = res.sort_by {|k,v| v }.reverse.to_h #sort by val 
	$all_channels_data = res
end
Thread.new { while true do; update_all_channels_last_day; sleep 60; end }

get '/chat_channels_data' do 
	# update_all_channels_last_day
	res = $all_channels_data
	return res
end

post '/chat/silence' do
	cast_id = pr[:cast_id]
	user_id = pr[:user_id]
	require_cast_owner(cast_id)
	
	$casts.update_id(cast_id, silenced_key(user_id) => true)
	
	$pusher.trigger(cast_chat_channel(cast), 'silence', {user_id: user_id})
	{msg: "ok"}
end

post '/chat/delete_msg' do
	cast_id = pr[:cast_id]
	msg_id  = pr[:msg_id]
	cast    = $casts.get(cast_id)
	chat    = $chat.get(msg_id)
	if chat 
		Thread.new {
			$chat.delete_one({_id: msg_id, user_id: cuid})	
			$pusher.trigger(cast_chat_channel(cast), 'delete-msg', {msg_id: msg_id})
		}
	end
	{msg: "ok"}
end

