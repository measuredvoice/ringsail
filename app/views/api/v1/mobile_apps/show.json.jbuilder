json.metadata do 
  json.set! :count, @mobile_apps.total_count
  json.set! :page, @mobile_apps.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @mobile_apps.total_pages
end
json.results do 
  json.array! @mobile_apps, partial: "api/v1/shared/mobile_app", as: :mobile_app, show_versions: true
end