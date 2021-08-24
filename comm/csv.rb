require('csv')

def load_csv(path)
	rows = CSV.read(File.expand_path path)
end

def upsert_users_from_csv(path)
	rows = load_csv(path)
	headers = rows[0].map {|s| s.downcase }
	
	rows.each_with_index do |row,idx|
		email = row[5].to_s.downcase
		next unless email.present?
		data = {
			csv: true,
			name: row[1],
			address: row[2],
			phone: row[4],
			email: email
		}
		
		# $users.update_one({email: email}, data, upsert: true)
		user = $users.get(email: email)
		puts "no user for email #{email}" unless user 
		# puts "idx: #{idx}, updating #{email}, user_id: #{$users.get(email: email)[:_id]}"
	end

	puts "done."
end

# path = '~/Downloads/data_ca_1.csv'
# >> upsert_users_from_csv('~/Downloads/data_ca_1.csv'); data.size