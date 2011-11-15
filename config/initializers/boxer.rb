# Make URL helpers available in all boxes
Boxer.configure do |config|
  config.box_includes = [Rails.application.routes.url_helpers]
end

# Load all box definitions from lib/boxer/*.rb
Dir[File.join(Rails.root, 'lib', 'boxer', '**', '*.rb')].each do |f|
  require_dependency f
end

class XBoxer < Hash
  def initialize(root, hash = {})
    @root = root
    self.merge!(hash)
  end
  def to_xml(options = {})
    options[:dasherize] = false
    options[:skip_types] = true
    options[:root] = @root
    super(options)
  end
end
