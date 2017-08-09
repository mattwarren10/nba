require 'nokogiri'
require 'open-uri'

module CallNokogiri
	def self.from url
    	page = Nokogiri::HTML(open(url))
    	
	end

	def self.css url, elements
		page = from url
		page.css(elements)
	end

	def self.xpath url, elements
		page = from url
		page.xpath(elements)
	end
end