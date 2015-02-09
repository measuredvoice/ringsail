class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  argument :service_name, :type => :string, :default => "example"
  def create_service_file
    service_name = file_name
    template "service_file.rb", "lib/services/#{service_name.downcase}_service.rb"
  end

  def create_service_spec_file
    service_name = file_name
    template "service_spec_file.rb", "spec/services/#{service_name.downcase}_service_spec.rb"
  end

end
