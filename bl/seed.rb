def add_seed_data
	users = [
		{_id: 'a1', handle: 'a1', email: 'biz@a1.com', name: 'Cool Cannabis Labs'}
	]

	# pre-rolls, mini-joints, bongs, cartridges, vapes, hash, capsules, gummies, dog treats, chocolates, coffee, tinctures, bud, skin lotion, oils
	products = [
		{user_id: 'a1', cost_dollars: 10, desc: 'my awesome product'}
	]

	users.each {|user| $users.update_id(user[:_id], user, {upsert: true }) }
	products.each {|cast| $casts.update_id(cast[:_id], cast, {upsert: true }) }
end


def add_seed_users
	$users.delete_many(seed: true)
	$seed_users[:results].to_a.each_with_index do |user, idx| 
		puts "idx #{idx}"
		name   = "#{user[:name][:first]} #{user[:name][:last]}"
		email  = user[:email]
		handle = user[:login][:username]

		contact = "#{[Faker::Internet.email, email, handle].sample} #{['on Instagram', 'on Facebook', 'on Twitch', 'at gmail', 'on tiktok', 'on reddit',' ',' ',' ',' '].sample}"			
		data = {
			seed: true,
			name: name,
			email: email,
			handle: handle,
			img_url: user[:picture][:medium],
			title: SAMPLE_SEARCHES.mapo(:label).sample.to_s[0..-2],
			#desc: Faker::Company.bs,
			contact: contact
		}
		$users.add(data)
	end
end

def remove_seed_users
	$users.delete_many(seed: true)
end


