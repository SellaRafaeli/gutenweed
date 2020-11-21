$reviews = $mongo.collection('reviews')

REVIEW_FIELDS = ['_id', 'buyer_id', 'seller_id', 'text']

def seller_reviews(seller_id)
	$reviews.get_many(seller_id: seller_id)
end

def buyer_reviews(buyer_id)
	$reviews.get_many(seller_id: seller_id)
end


# def user_reviews(user = {})
# 	return [] unless user && user[:_id]
# 	# reviews of this user 
# 	$reviews.get_many(user_id: user[:_id])
# end

# def cast_reviews(cast_id)
# 	$reviews.get_many(cast_id: cast_id).to_a
# end

# def can_delete_review(review) 
# 	return false unless review 
# 	(review[:cast_owner_id] == cuid) || (review[:reviewer_id] == cuid) || is_admin
# end

# post '/reviews/new' do 
# 	require_user 

# 	data = pr.just(:cast_id, :msg, :rating)
# 	data[:reviewer_id]   = cuid 
# 	data[:cast_owner_id] = $casts.get(data[:cast_id])[:user_id]
# 	data[:rating]        = pr[:rating].to_i 
# 	data[:rating]        = 5 if data[:rating] > 5
# 	data[:rating]        = 1 if data[:rating] < 1
	
# 	$reviews.add(data)

# 	flash.message = 'Review submitted.'
# 	redirect back
# end

# post '/reviews/:id/delete' do 
# 	require_user 

# 	if can_delete_review($reviews.get(pr[:id])) 
# 		$reviews.delete_one(_id: pr[:id])
# 		flash.message = 'Deleted.'
# 		redirect back
# 	else 
# 		flash.message = 'Sorry, you cannot do that.'
# 		redirect back
# 	end
# end