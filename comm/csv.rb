require('csv')

def load_csv(path)
	rows = CSV.read(File.expand_path path)
end

def upsert_users_from_csv(path)
	rows = load_csv(path)
	headers = rows[0].map {|s| s.downcase }
	
	rows.each_with_index do |row,idx|
		next if idx == 0
		email = row[2].to_s.downcase
		next unless email.present?
		data = {
			csv: true,
			csv_version: 'disp2',
			name: row[1],
			email: row[2],
			phone: row[3],			
			address: row[4],
			city: row[5].to_s.capitalize,
			state: row[6],
			website: row[7],
			license_numbers: row[8],
		}
		
		puts "#{idx}: #{email}"
		$users.delete_one({email: email})
		begin
			$users.update_one({email: email}, {'$set': data}, upsert: true)
		rescue => e 
			puts e.to_s.red
		end
		# user = $users.get(email: email)
		# puts "no user for email #{email}" unless user 
		# puts "idx: #{idx}, updating #{email}, user_id: #{$users.get(email: email)[:_id]}"
	end

	puts "done."
end

# path = '~/Downloads/data_ca_1.csv'
# >> upsert_users_from_csv('~/Downloads/disp2.csv');