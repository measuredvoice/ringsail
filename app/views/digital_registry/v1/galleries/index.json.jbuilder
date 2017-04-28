json.metadata do
  json.set! :count, @galleries.total_count
  json.set! :page, @galleries.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @galleries.total_pages
end
json.results do 
  json.array! @galleries, partial: "digital_registry/v1/shared/gallery", as: :gallery
end