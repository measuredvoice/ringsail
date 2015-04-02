json.data @users do |user|
  json.set! "DT_RowId", user.id
  json.set! :name, user.email
  json.set! :agency, user.agency.try(:name)
  json.set! :role, user.role.try(:humanize)
  json.set! :sign_in_count, user.sign_in_count
  json.set! :last_sign_in_at, user.last_sign_in_at ? user.last_sign_in_at.strftime("%B %e, %Y %H:%M %Z") : ""
end