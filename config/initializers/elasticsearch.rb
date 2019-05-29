ELASTIC_SEARCH_CLIENT = nil
if ENV['REGISTRY_ES_HOST'] 
  config = {
    host: "#{ENV['REGISTRY_ES_HOST']}:#{ENV['REGISTRY_ES_PORT']}/",
    transport_options: {
      request: { timeout: 5 },
      ssl: { verify: false}
    },
    log: true
  }

  Elasticsearch::Model.client = Elasticsearch::Client.new(config)
  ELASTIC_SEARCH_CLIENT = Elasticsearch::Client.new(config)
end