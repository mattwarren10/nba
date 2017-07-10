require 'net/http'
require 'net/https'

class Player < ApplicationRecord
  belongs_to :team

	# Request (GET )
	def send_request
	  uri = URI("https://www.mysportsfeeds.com/api/feed/pull/nba/2017-playoff/active_players.json")

	  # Create client
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

	  # Create Request
	  req =  Net::HTTP::Get.new(uri)
	  # Add headers
	  req.add_field "Authorization", "Basic " + base64_encode(ENV['USER'] + ":" + ENV['PASS'])

	  # Fetch Request
	  res = http.request(req)
	  @result = JSON.parse(res)
	  puts "Response HTTP Status Code: #{res.code}"
	  puts "Response HTTP Response Body: #{res.body}"
	rescue StandardError => e
	  puts "HTTP Request failed (#{e.message})"
	end
end
