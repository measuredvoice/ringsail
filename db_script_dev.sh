
rake db:drop
rake db:create
mysql -u root ringsail_development < data/current/socialmed.sql
rake db:migrate

rake load_apps_gallery_data:agencies
rake load_apps_gallery_data:contacts
rake load_apps_gallery_data:mobile_apps
rake load_apps_gallery_data:galleries

# rake db:drop
# rake db:create
# rake db:migrate
# rake db:seed
#RAILS_ENV=development bundle exec rake environment elasticsearch:import:model CLASS='MobileApp' FORCE=y
#RAILS_ENV=development bundle exec rake environment elasticsearch:import:model CLASS='Outlet' FORCE=y


#RAILS_ENV=production bundle exec rake environment elasticsearch:import:model CLASS='MobileApp' FORCE=y
#RAILS_ENV=production bundle exec rake environment elasticsearch:import:model CLASS='Outlet' FORCE=y