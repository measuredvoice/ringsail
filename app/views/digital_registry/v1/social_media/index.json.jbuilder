json.metadata do 
  json.set! :count, @outlets.total_count
  json.set! :page, @outlets.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @outlets.total_pages
end
json.results do
  json.array! @outlets, partial: "digital_registry/v1/shared/social_media", as: :outlet
end