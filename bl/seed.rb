$seed_data = 



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