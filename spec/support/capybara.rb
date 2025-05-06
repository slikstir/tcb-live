require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, headers: { 'HTTP_USER_AGENT' => 'Capybara' })
end

Capybara.configure do |config|
  config.default_driver         = :rack_test
  config.app_host               = "http://#{IPSocket.getaddress(Socket.gethostname)}:3000"
  config.server_host            = IPSocket.getaddress(Socket.gethostname)
  config.server_port            = 3000
  config.server                 = :puma, { Silent: true }
end

# Define Chrome options
args = [
  '--disable-dev-shm-usage',
  '--no-default-browser-check',
  '--start-maximized',
  '--window-size=1600,1200'
]

chrome_options = Selenium::WebDriver::Chrome::Options.new
args.each { |arg| chrome_options.add_argument(arg) }

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: "http://selenium:4444/wd/hub",
    capabilities: chrome_options
  )
end

# Ensure the JavaScript driver is set AFTER registering :selenium
Capybara.javascript_driver = :selenium
