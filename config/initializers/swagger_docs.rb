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
    :api_file_path => "app/views/swagger/swagger_docs",
    # the URL base path to your API
    :base_path => "#{ENV['REGISTRY_API_HOST']}",
    # if you want to delete all .json files at each generation
    :base_api_controller => "Api::ApiController",
    :clean_directory => true,
    # add custom attributes to api-docs
    :attributes => {
      :info => {
        "title" => "Social Media & Mobile Products Registry",
        "description" => "<p>The Social Media and Mobile Products Registry feeds the Federal Social Media and Mobile Products API.
          This API populates the USAgov Federal Government Mobile Apps Directory, and is used by social media firms
          to verify the authenticity of government social media accounts.</p>

          <p>Federal government social media and mobile products managers can register, edit and review their agency’s
             products.  Accessing the Social Media and Mobile Products Registry requires an OMB Max ID, which is available
             to federal government employees and contractors with a valid .gov, .mil, or .fed.us email address.
             <a href=\"https://max.omb.gov/maxportal/registrationForm.action\">Register for an OMB Max ID</a> if you need one.</p>
         <p><a class=\"btn btn-default\" href=\"/admin/\">LOG IN</a></p>
         <h2>API Documentation</h2>
        <p>The API documentation below serves as both a way to learn how to use the API, but to also test it directly in your browser.</p>"
      }
    }
  }
})
