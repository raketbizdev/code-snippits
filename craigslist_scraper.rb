require 'open-uri'
require 'json'

# Set Api Token
auth_token = '4d942c27c448b9b2e4a78f4b519dca5e'
polling_url = 'http://polling.3taps.com/poll'

# Specify Request Parameters
params = {
	auth_token: auth_token,
	anchor: 2495234340,
	source: "E_BAY",
	# category_group: "PPPP",
	category: "SAPL",
	'location.city' => "USA-NYM-BRL",
	retvals: "location,external_url,heading,body,timestamp,price,images,annotations"
}
# Prepare API Request
uri = URI.parse(polling_url)
uri.query = URI.encode_www_form(params)

# Submit Request
result = JSON.parse(open(uri).read)

# Display Results
puts JSON.pretty_generate result