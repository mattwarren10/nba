require 'net/http'
require 'net/https'

class Player < ApplicationRecord
  belongs_to :team
  
  validates_presence_of :last_name, 
  						:first_name, 
  						:jersey_number, 
  						:position, 
  						:height, 
  						:weight, 
  						:birth_date, 
  						:age, 
  						:birth_city
  

	# Request (GET )
	def self.send_request
      user = ENV['NBA_USER']
  	  pass = ENV['NBA_PASS']
	  uri = URI("https://www.mysportsfeeds.com/api/feed/pull/nba/2017-playoff/active_players.json")

	  # Create client
	  http = Net::HTTP.new(uri.host, uri.port)
	  http.use_ssl = true
	  http.verify_mode = OpenSSL::SSL::VERIFY_PEER

	  # Create Request
	  req =  Net::HTTP::Get.new(uri)
	  # Add headers
	  req.add_field "Authorization", "Basic " + Base64.encode64("#{user}:#{pass}")

	  # Fetch Request
	  response = http.request(req)	  
	  puts "Response HTTP Status Code: #{response.code}"
	  puts "Response HTTP Response Body: #{response.body}"	  

	  result = JSON.parse(response.body)
	end
end
