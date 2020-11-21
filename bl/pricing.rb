NOWCAST_PRO = 'nowcast_pro'

def get_nowcast_pro_cast
	$casts.get(tags: NOWCAST_PRO)
end

def is_pro(user = cu)
	return false
	user && user[NOWCAST_PRO]
end