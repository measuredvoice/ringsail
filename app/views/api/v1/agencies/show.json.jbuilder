json.metadata do
  json.set! :count, @agencies.total_count
  json.set! :page, @agencies.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @agencies.total_pages
end
json.results do 
  json.array! @agencies, partial: "api/v1/shared/agency", as: :agency, locals: {include_counts: true}
end