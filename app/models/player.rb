require 'net/http'
require 'net/https'

class Player < ApplicationRecord
  belongs_to :team
  
  # validates :team_id, presence: true,
  # validates :last_name, presence: true
  # validates :first_name, presence: true
  # validates :jersey_number, presence: true
  # validates :position, presence: true
  # validates :height, presence: true
  # validates :weight, presence: true
  # validates :birth_date, presence: true
  # validates :age, presence: true
  # validates :birth_city, presence: true
  

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
