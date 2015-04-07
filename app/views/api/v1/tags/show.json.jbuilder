json.metadata do 
  json.set! :count, @official_tags.total_count
  json.set! :page, @official_tags.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @official_tags.total_pages
end
json.results do 
  json.array! @official_tags, partial: "api/v1/shared/official_tag", as: :official_tag, counts: true
end