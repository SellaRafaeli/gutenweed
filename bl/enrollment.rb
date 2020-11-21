$enrolls = $enrollment = $mongo.collection('enrollment')

ENROLL_ACTIVE   = 'active'
ENROLL_CANCELED = 'canceled'

# user_id - enrolling user
# cast_id - enrolled cast

def enroll_user(user_id, cast_id, data = {})
	data[:user_id] = user_id
	data[:cast_id] = cast_id
	data[:status]  = ENROLL_ACTIVE

	if enroll = $enrolls.get(user_id: user_id, cast_id: cast_id)
		$enrolls.update_id(enroll[:_id], data)
	else 
		$enrolls.add(data)
	end	
	
	$users.update_id(user_id, nowcast_pro: Time.now) if $casts.get(cast_id)[:tags].to_s.include?(NOWCAST_PRO)
	send_enrollment_emails(user_id, cast_id)
rescue => e 
	log_e(e)
end

def user_enrolled(user_id, cast)
	# return true if cast[:user_id] == user_id #owner
	return false unless user_id.present?
	$enrolls.get(user_id: user_id, cast_id: cast[:_id], status: ENROLL_ACTIVE) 
rescue => e 
	puts e.to_s.red
	log_e(e)
	false
end

def users_enrolled_in_cast(cast)
	cast_id = cast[:_id]
	enrolls = $enrolls.get_many(cast_id: cast_id, status: ENROLL_ACTIVE) 
	users   = enrolls.map {|enroll| 
		user = $users.get(enroll[:user_id])
		user[:enroll] = enroll 
		user
	}.uniq
	users
end

def casts_for_user(user_id)
	enrolls = $enrolls.get_many(user_id: user_id, status: ENROLL_ACTIVE) 
	casts   = enrolls.map {|enroll| $casts.get(enroll[:cast_id]) }.compact
	casts
end

def send_enrollment_emails(user_id, cast_id)
	viewer = $users.get(user_id)
	cast   = $casts.get(cast_id)
	owner  = $users.get(cast[:user_id])

	# notify viewer
	html = email_by_view('enrollment_welcome', cast: cast, viewer: viewer, owner: owner)
	send_email(viewer[:email], "Thanks for joining '#{cast['title']}!'", html)

	# notify owner
	html = email_by_view('enrollment_inform_owner', cast: cast, viewer: viewer, owner: owner)
	send_email(owner[:email], "New viewer for '#{cast['title']}: #{viewer['name']}'", html)
end

def cancel_enroll(enroll)
	$enrolls.update_id(enroll[:_id], canceled_at: Time.now, status: ENROLL_CANCELED)
	if (stripe_sub_id = enroll[:sub_id] || enroll[:stripe_sub_id])
		cancel_stripe_sub(stripe_sub_id)
	end

	cast = $casts.get(enroll[:cast_id]) 
	if (cast && cast[:tags].to_s.include?(NOWCAST_PRO))
		$users.update_one({_id: cuid}, {'$unset': {NOWCAST_PRO => 1}})
	end
rescue => e
	log_e(e)
	false
end

def update_expired_enrolls(time = Time.now)
	old_enrolls = $enrolls.all(expires_at: {'$lt': time})
	old_enrolls.each {|enroll| 
		cancel_enroll(enroll[:_id])
	}
end

post '/enrollment/cancel' do 
	require_user
	
	enroll = $enrolls.get(user_id: cuid, cast_id: pr[:cast_id], status: ENROLL_ACTIVE)
	
	if enroll
		cancel_enroll(enroll)
		{msg: 'ok'}
	else 
		halt(404,{err: 'No such enrollment'})
	end
end

post '/joinFree' do 
	cast_id = pr[:cast_id]
	cast    = $casts.get(cast_id)
	halt(401, {err: 'not free'}) if !(cast_free(cast) || cast_allows_variable_amount(cast))

	# if no user, force signup, If user exists, just enroll.
	verify_signup_data if !cu
	add_user if !cu
	enroll_user(cuid, cast_id)
	{msg: 'ok'}
end