if ENV['REGISTRY_ES_HOST'] 
  config = {
    host: "#{ENV['REGISTRY_ES_HOST']}:#{ENV['REGISTRY_ES_PORT']}/",
    transport_options: {
      request: { timeout: 5 }
    },
  }

  Elasticsearch::Model.client = Elasticsearch::Client.new(config)
end