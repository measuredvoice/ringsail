json.partial! "api/v1/shared/gallery", gallery: @gallery
json.gallery_items do
  json.array! @gallery.gallery_items do |gallery_item|
    if gallery_item.item.status = 1
      if gallery_item.item.class == MobileApp
        json.type "Mobile App"
        json.partial! "api/v1/shared/mobile_app", mobile_app: gallery_item.item
      else
        json.type "Social Media"
        json.partial! "api/v1/shared/social_media", outlet: gallery_item.item
      end
    end
  end
end