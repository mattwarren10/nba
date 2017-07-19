require 'selenium-webdriver'

module ChromeSelenium
	def self.opt
		options = Selenium::WebDriver::Chrome::Options.new
		options.add_argument('--disable-gpu')
		options.add_argument('--headless')
		options.add_argument('--ignore-certificate-errors')
		options
	end

	def self.call	
		puts "Accessing driver path..."	
		Selenium::WebDriver::Chrome.driver_path="/usr/local/bin/chromedriver"
		puts "Requesting options..."
		options = opt
		driver = Selenium::WebDriver.for :chrome, options: options
	end

	def self.send elements, url
		puts "Initializing driver..."
		driver = call

		puts "Navigating to url:" 
		puts "==> #{url}"		
		driver.navigate.to url

		puts "Finding elements:"
		puts "==> #{elements}"
		e = driver.find_elements(:css, elements)
		return e, driver	
	end

	def self.quit d
		d.quit
	end
end