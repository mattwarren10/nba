require 'selenium-webdriver'

module ChromeSelenium
	def self.call
		Selenium::WebDriver::Chrome.driver_path="/Users/mattwarren/dev/chrome_web_driver/chromedriver"
		driver = Selenium::WebDriver.for :chrome	
	end

	def self.send elements, url
		driver = ChromeSelenium.call
		driver.navigate.to url
		e = driver.find_elements(:css, elements)
	end
end