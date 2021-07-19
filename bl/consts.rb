LOGOS = [
  'logo_fb.png',
  'logo_zoom.jpg',
  'logo_youtube.png',  
  'logo_instagram.jpg',
  # 'logo_vimeo.png',
]

DOWS = [    
  {val: 'mon', label: 'Mondays'},
  {val: 'tue', label: 'Tuesdays'},
  {val: 'wed', label: 'Wednesdays'},
  {val: 'thu', label: 'Thursdays'},
  {val: 'fri', label: 'Fridays'},
  {val: 'sat', label: 'Saturdays'},
  {val: 'sun', label: 'Sundays'},
]

def dow_idx(dow) 
  DOWS.index {|d| d[:val] == dow.to_s }
end

def cur_day
  Date::ABBR_DAYNAMES[Date.today.wday].downcase
end

def tmw_day
  Date::ABBR_DAYNAMES[Date.today.wday+1].downcase
end

LIVE_PLATFORMS = [    
  {val: 'google_meet', label: 'Google Meet'},
  {val: 'zoom', label: 'Zoom'},
  {val: 'vimeo', label: 'Vimeo'},
  {val: 'fb', label: 'Facebook Messenger Room'},
  {val: 'yt', label: 'YouTube Live'},
  {val: 'custom_platform', label: 'Custom Platform'}
]

LIVE_PLATFORMS_HASH = { }
LIVE_PLATFORMS.each { |i| LIVE_PLATFORMS_HASH[i[:val]] = i[:label] }

# * For Beginners 
# - Coding 101
# - Introduction to Software Development 
# - SheCodes: Coding Workshops for Women
# - Web Apps 101 

# * Fullstack Bootcamps 
# - Zero to Portfolio Bootcamp
# - Flatirons 

# * Web Application Development (Frontend)
# - Fullstack development 101 
# - Advanced CSS 
# - Mastering Web App Development 
# - React 101
# - Vue 101
# - Angular 101 
# - Advanced JS 
# - Advanced CSS

# * Web Servers (Backend) 
# - Ruby & Rails: #1 Framework of Web Apps 
# - Ruby & Sinatra: Developer Happiness 
# - NodeJS 101 
# - Python 101 

# * For Kids 
# * Mind & Body

# Coming soon:
# * Data Science, UI/UX, Product Management 
# * Algorithms, AI, Machine Learning, NLP


# Web Application Development 
# * Web App Development 101  
# * JavaScript Dojo
# * Hello World to Portfolio - a 30-day Bootcamp 
# * Ruby - The Language for Happy Developers 

# Cybersecurity 
# * Intro to Cybersecurity 
# * How Hackers Work 
# * How to Make a Website Security Audit 
# * How to Become a Penetration Tester 

# Online Marketing
# * Online Marketing for Beginners 
# * 

# Data Science 
# * What is Data Science?

HOMEPAGE_TOPICS = [  
  # {topic: 'Top-Rated', tag: 'toprated'},
  #{topic: 'Coding for Beginners', tag: 'beginners'},
  {topic: 'Mind, Body & Art', tag: 'art', subtopics: ['Fitness']},
#  {topic: 'Fullstack', tag: 'bootcamp'},
  #{topic: 'Frontend', tag: 'frontend', subtopics: ['JavaScript', 'CSS', 'React', 'Vue', 'Angular']},
  #{topic: 'Backend', tag: 'backend', subtopics: ['Ruby', 'NodeJS', 'Python']},
  # {topic: 'Soft Skills', tag: 'soft_skills', subtopics: ['Job Searching', 'Interviewing', 'Software Professionalism']},
  
  # {topic: 'Cybersecurity'},
  # {topic: 'Online Marketing'},
  # {topic: 'Data Science'},
  # {topic: 'UX Design'},
  # {topic: 'Graphic Design'},
  # {topic: 'Product Management'}
]

SAMPLE_SEARCHES = [
  {label: 'Fitness coaches', v:nil },
  {label: 'Dance lessons', v:nil },
  {label: 'Yoga teachers', v:nil },
  {label: 'Actors', v:nil },
  {label: 'Aerobics teachers', v:nil },
  {label: 'Storytellers', v:nil },
  {label: 'Consultants', v:nil },
  {label: 'Therapists', v:nil },
  {label: 'Coaches', v:nil },
  {label: 'Meditation teachers', v:nil },
  {label: 'Public speakers', v:nil },
  {label: 'Entertainers', v:nil },
  {label: 'Comedians', v:nil },
  {label: 'Musicians', v:nil },
  {label: 'Graphic Designers', v:nil },
  {label: 'Video editors', v:nil },
  {label: 'Content editors', v:nil },
  {label: 'Domain experts', v:nil },
  {label: 'English teachers', v:nil },
  {label: 'Spanish teachers', v:nil },
  {label: 'Chinese teachers', v:nil },
]

TIME_ZONES = [
  {val:-12, label: 'UTC/GMT -12:00 (Baker Island, Howland Island)'},
  {val:-11, label: 'UTC/GMT -11:00 (American Samoa, Niue NZ)'},
  {val:-10, label: 'UTC/GMT -10:00 (Honolulu, Cook Islands NZ)'},
  {val:-9, label: 'UTC/GMT -09:00 (Anchorage, French Polynesia)'},
  {val:-8, label: 'UTC/GMT -08:00 (San Francisco, Los Angeles, Vancouver, Tijuana)'},
  {val:-7, label: 'UTC/GMT -07:00 (Phoenix, Calgary, Ciudad Juarez)'},
  {val:-6, label: 'UTC/GMT -06:00 (Mexico City, Chicago, Guatemala City, Winnipeg, San José, San Salvador)'},
  {val:-5, label: 'UTC/GMT -05:00 (New York, Toronto, Havana, Lima, Bogotá)'},
  {val:-4, label: 'UTC/GMT -04:00 (Santiago, Santo Domingo, Manaus, La Paz, Halifax)'},  
  {val:-3, label: 'UTC/GMT -03:00 (São Paulo, Buenos Aires)'},
  {val:-2, label: 'UTC/GMT -02:00 (Fernando de Noronha, South Georgia)'},
  {val:-1, label: 'UTC/GMT -01:00 (Cape Verde, Ittoqqortoormiit Greenland)'},
  {val: 0, label: 'UTC/GMT +00:00 (London, Dublin, Lisbon, Dakar)'},
  {val: 1, label: 'UTC/GMT +01:00 (Berlin, Rome, Paris, Madrid, Warsaw, Casablanca)'},  
  {val: 2, label: 'UTC/GMT +02:00 (Cairo, Johannesburg, Khartoum, Kiev, Athens, Jerusalem)'},
  {val: 3, label: 'UTC/GMT +03:00 (Moscow, Istanbul, Baghdad, Addis Ababa, Doha)'},
  {val: 4, label: 'UTC/GMT +04:00 (Dubai, Baku, Tbilisi)'},
  {val: 5, label: 'UTC/GMT +05:00 (Karachi, Tashkent)'},
  {val: 6, label: 'UTC/GMT +06:00 (Dhaka, Almaty, Omsk)'},
  {val: 7, label: 'UTC/GMT +07:00 (Bangkok, Krasnoyarsk)'},
  {val: 8, label: 'UTC/GMT +08:00 (Shanghai, Taipei, Kuala Lumpur, Singapore, Perth, Manila)'},
  {val: 9, label: 'UTC/GMT +09:00 (Tokyo, Seoul, Pyongyang)'},
  {val: 10, label: 'UTC/GMT +10:00 (Sydney, Port Moresby, Vladivostok)'},
  {val: 11, label: 'UTC/GMT +11:00 (Norfolk Island, Sakha Republic, Solomon Islands)'},
  {val: 12, label: 'UTC/GMT +12:00 (Auckland, Petropavlovsk-Kamchatsky)'}
]

USER_PAGE_THEMES = [
  {val: '', label: 'Default'},
  {val: 'playful', label: 'Playful'}
]

GEOGRAPHIC_AREAS = [
  {val: 'bay_area',     label: 'San Francisco & Bay Area'},
  {val: 'los_angeles',  label: 'Los Angeles'},
  {val: 'portland',     label: 'Portland'},
  {val: 'seattle',      label: 'Seattle'},
  {val: 'tel_aviv',     label: 'Tel Aviv'},
  {val: 'israel',     label: 'Israel'},
  {val: 'nyc',     label: 'New York City'},
  {val: 'mexico_city',  label: 'Mexico City'},
  {val: 'italy',  label: 'Italy'},
  {val: 'united_kingdom'  ,  label: 'United Kingdom'},
].sort_by {|area| area[:label] }

US_STATES = [
  {val: 'CA',    label: 'California'},
  {val: 'WA',    label: 'Washington'},
  {val: 'OR',    label: 'Oregon'},
  {val: 'NY',    label: 'New York'},
]

US_STATES_CITIES = {
    'California': ['San Francisco', 'San Jose', 'Sacramento', 'Los Angeles', 'San Diego'].sort,        
    'Nevada': ['Reno', 'Las Vegas', 'Carson City'].sort,
    'Oregon': ['Portland', 'Eugene', 'Bend'].sort,
    'Washington': ['Seattle', 'Olympia', 'Spokane'].sort,
  }

PRODUCT_TYPES = {
    'Edibles': ['Edibles', 'Gummies', 'Chocolates', 'Brownies', 'Mints'].sort,
    'Flower': ['Flower', 'Alaska', 'Purple Haze', 'Lemon Kush'].sort,    
    'Tinctures': ['Tinctures', 'CBD Oil', 'THC Oil'].sort,
    'Other': ['Other'].sort,
  }


COUNTRIES = [
  {val: 'usa',    label: 'United States'},
  {val: 'uk',     label: 'United Kingdom'},
  {val: 'ar',     label: 'Argentina'},
  {val: 'austria',      label: 'Austria'},
  {val: 'australia',    label: 'Australia'},
  {val: 'be',    label: 'Belgium'},
  {val: 'br',    label: 'Brazil'},
  {val: 'ca',    label: 'Canada'},
  {val: 'ch',    label: 'Chile'},
  {val: 'co',    label: 'Colombia'},
  {val: 'cr',    label: 'Costa Rica'},
  {val: 'croatia',    label: 'Croatia'},
  {val: 'cz',    label: 'Czech Republic'},
  {val: 'dn',    label: 'Denmark'},
  {val: 'fi',    label: 'Finland'},
  {val: 'fr',    label: 'France'},
  {val: 'de',    label: 'Germany'},
  {val: 'gu',    label: 'Guatemala'},
  {val: 'hu',    label: 'Hungary'},
  {val: 'ir',    label: 'Ireland'},
  {val: 'is', label: 'Israel'},
  {val: 'it',    label: 'Italy'},
  {val: 'la',    label: 'Latvia'},
  {val: 'li',    label: 'Lithuania'},
  {val: 'me',    label: 'Mexico'},
  {val: 'ne',    label: 'Netherlands'},
  {val: 'nz',    label: 'New Zealand'},
  {val: 'no',    label: 'Norway'},
  {val: 'pa',    label: 'Panama'},
  {val: 'pe',    label: 'Peru'},
  {val: 'po',    label: 'Poland'},   
  {val: 'portugal',    label: 'Portugal'},   
  {val: 'slovakia',    label: 'Slovakia'},   
  {val: 'slovenia',    label: 'Slovenia'},   
  {val: 'es',    label: 'Spain'},   
  {val: 'sw',    label: 'Sweden'},   
  {val: 'switzerland',    label: 'Switzerland'},   
  {val: 'uk',    label: 'United Kingdom'},   
  {val: 'ur',    label: 'Uruguay'},   
  {val: 've',    label: 'Venezuela'},   
]

LANGUAGES = [  
  {val: 'en', label: 'English'},
  {val: 'es', label: 'Spanish'},
  {val: 'ru', label: 'Russian'},  
  {val: 'he', label: 'Hebrew' }  
]

SEARCH_OPTS = ['test', 'sativa', 'indica', 'joints', 'brownies', 'bongs', 'Kush', 'Afghan Kush', 'Hindu Kush', 'Green Kush', 'Purple Kush', 'Blueberry Kush', 'Golden Jamaican Kush', 'Diesel Haze'] 

STRAINS = [
  {val: 'Sativa', label: 'English'},
  {val: 'es', label: 'Spanish'},
  {val: 'ru', label: 'Russian'},  
  {val: 'he', label: 'Hebrew' }  
]

ITEM_TYPES = [
  {val: 'en', label: 'English'},
  {val: 'es', label: 'Spanish'},
  {val: 'ru', label: 'Russian'},  
  {val: 'he', label: 'Hebrew' }  
]

SOCIAL_NETWORKS = [
  'website', 'twitter', 'instagram', 'facebook', 'linkedin', 'github'
]

#CAST_TYPES_PLURAL = ['Bootcamps', 'Lectures', 'Classes', 'Courses', 'Webinars', 'Shows', 'Social Events', 'Team-Building Events']

# CAST_TYPES_PLURAL = ['Coding', 'Cybersecurity', 'Data Science', 'Online Marketing', 'Product Management', 'UI/UX', 'Graphic Design']

#CAST_TYPES_PLURAL = ['Full-Stack', 'Web Development', 'React', 'SQL', 'Cybersecurity', 'Data Science', 'SEO', 'JavaScript', 'CSS', 'Ruby', 'Python', 'Mind & Body', 'Git', 'MongoDB', 'NodeJS', 'Wordpress', 'Interviewing', 'Job Searching']

#CAST_TYPES_PLURAL = ['Tech', 'Fitness', 'Languages', 'Marketing', 'Photography', 'Dance', 'React', 'SQL', 'Cybersecurity', 'Art', 'Data Science', 'SEO', 'JavaScript', 'CSS', 'Python', 'Photoshop', 'Git', 'MongoDB', 'NodeJS'] #, 'Wordpress', 'Interviewing', 'Job Searching']

#CAST_TYPES_PLURAL = ['Programming', 'Fitness', 'Languages', 'Mental Well-Being', 'Marketing', 'Photography', 'Dance', 'React', 'SQL', 'Cybersecurity', 'Data Science', 'SEO', 'JavaScript', 'CSS', 'Python', 'Photoshop'] #, 'Wordpress', 'Interviewing', 'Job Searching']

# CAST_TYPES_PLURAL = ['Languages', 'Fitness', 'Coding', 'Graphic Design', 'Mental Well-Being', 'Online Marketing', 'Photography', 'Data Science', 'Religion', 'Spirituality', 'SQL', 'Photoshop']#.sort

CAST_TYPES_PLURAL = ['Languages', 'Fitness', 'Tech', 'Business', 'Mental Well-Being', 'Lifestyle']#.sort

FORUM_THREAD = 'Discussion Thread'
CAST_TYPES_SINGLE = ['Class', 'Course', 'Lecture', 'Webinar']

REFERRAL_PCT    = 10
REFERRAL_MONTHS = 6


ORDER_STATUSES = ['new', 'in progress', 'shipped', 'received', 'reviewed']