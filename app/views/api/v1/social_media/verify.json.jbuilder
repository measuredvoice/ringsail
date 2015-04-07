json.metadata do
  json.set! :verified, @outlet ? true : false
end
json.results do 
  json.array! @outlet, partial: "api/v1/shared/social_media", as: :outlet
end