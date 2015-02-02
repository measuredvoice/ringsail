namespace :swagger do
  task :docs do
    Rake::Task["swagger:docs"].invoke
    json = nil;
    File.open("public/swagger_docs/api-docs.json", "r" ) do |f|
      json = JSON.load(f)
      json["basePath"] = json["basePath"] + "swagger_docs/"
    end
    File.open("public/swagger_docs/api-docs.json", "w" ) do |f|
      f << json.to_json
    end
  end
end