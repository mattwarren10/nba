require 'selenium-webdriver'

module CallSelenium link
	def self.get_selenium_from
		Selenium::WebDriver::Chrome.driver_path="/Users/mattwarren/dev/chrome_web_driver/chromedriver"
		driver = Selenium::WebDriver.for :chrome
		driver.navigate.to link
		driver
	end
end