class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "#{ENV['REGISTRY_HOSTNAME']}/swagger_docs/#{path}"
  end
end
Swagger::Docs::Config.register_apis({
  "1.0" => {
    # the extension used for the API
    :api_extension_type => :json,
    # the output location where your .json files are written to
    :api_file_path => "public/swagger_docs",
    # the URL base path to your API
    :base_path => "#{ENV['REGISTRY_API_HOST']}",
    # if you want to delete all .json files at each generation
    :base_api_controller => "Api::ApiController",
    :clean_directory => true,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "U.S. Digital Services Registry",
        "description" => "This registry serves as a central source of Government sponsored social media and mobile applicaitons.
          This documentation serves as both a way to learn how to use the api, but to also test it directly in your browser.",
        "termsOfServiceUrl" => "http://registry.digitalgov.gov",
        "contact" => "registry@digitalgov.gov",
        "license" => "MIT License",
        "licenseUrl" => "http://opensource.org/licenses/MIT"
      }
    }
  }
})