json.metadata do
  json.set! :count, @galleries.total_count
  json.set! :page, @galleries.current_page
  json.set! :page_size, params[:page_size].to_i
  json.set! :pages, @galleries.total_pages
end
json.results do 
  json.array! @galleries do |gallery|
    json.partial! "api/v1/shared/gallery", gallery: gallery
    json.gallery_items do
      json.array! gallery.gallery_items do |gallery_item|
        if gallery_item.item.published
          if gallery_item.item.class == MobileApp
            json.type "Mobile App"
            json.partial! "api/v1/shared/mobile_app", mobile_app: gallery_item.item.published, show_versions: true
          else
            json.type "Social Media"
            json.partial! "api/v1/shared/social_media", outlet: gallery_item.item.published
          end
        end
      end
    end
  end
end
