json.metadata do
  json.set! :count, @government_urls.total_count
  json.set! :page, @government_urls.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @government_urls.total_pages
end
json.results do
  json.array! @government_urls, partial: "digital_registry/v1/shared/government_url", as: :government_url
end
