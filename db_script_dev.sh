rake db:drop
rake db:create
mysql -u root ringsail_development < data/current/socialmed.sql
rake db:migrate
rake load_apps_gallery_data:contacts
rake load_apps_gallery_data:agencies
rake load_apps_gallery_data:mobile_apps
rake load_apps_gallery_data:galleries