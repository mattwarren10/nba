require 'selenium-webdriver'

module CallSelenium
	def self.call
		Selenium::WebDriver::Chrome.driver_path="/Users/mattwarren/dev/chrome_web_driver/chromedriver"
		driver = Selenium::WebDriver.for :chrome
		driver		
	end
end