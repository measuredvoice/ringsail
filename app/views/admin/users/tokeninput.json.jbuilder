json.array! @users do |user|
  json.id user.id
  json.name user_list_format(user)
end