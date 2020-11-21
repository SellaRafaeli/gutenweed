EMPTY_TERMS = ['lesson', 'class', 'course', 'teacher', 'expert', 'tutor']

def cleanup_search(src)
	EMPTY_TERMS.each do |term|
		src = src.to_s.gsub(term+'s','').to_s.gsub(term+'es','').to_s.gsub(term,'')
	end	

	src
end