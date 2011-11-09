# Make URL helpers available in all boxes
Boxer.configure do |config|
  config.box_includes = [Rails.application.routes.url_helpers]
end

