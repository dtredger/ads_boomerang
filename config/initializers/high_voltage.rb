# https://github.com/thoughtbot/high_voltage

HighVoltage.configure do |config|
  config.home_page = 'home'

  # deactivate pages available from pages/:id
  config.routes = false

  # # remove the directory pages from the URL path and serve up routes from the root of the domain path
  config.route_drawer = HighVoltage::RouteDrawers::Root

  config.layout = "pages/base.html"
end