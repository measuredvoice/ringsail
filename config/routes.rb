Ringsail::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users
  
  # API call /accounts/verify, GET
  # and synonym /accounts/{service}/{account}, GET
  match "accounts/verify" => "outlets#verify", :via => :get, :as => :verify_outlet
  match "accounts/:service/:account" => "outlets#verify", :via => :get, :as => :show_outlet
  
  root :to => "outlets#verify"

  # API call /accounts, GET
  # and synonym /accounts/{service}, GET
  match "accounts" => "outlets#list", :via => :get, :as => :list_outlets
  match "accounts/:service_id" => "outlets#list", :via => :get, :as => :list_service_outlets

  # API call /outlets/register, both GET and POST
  match "accounts/register" => "outlets#add", :via => :get, :as => :add_outlet
  match "accounts/register" => "outlets#update", :via => :post, :as => :update_outlet
  
  # API call /outlets/remove, either DELETE or POST
  match "accounts/remove" => "outlets#remove", :via => :post, :as => :remove_outlet
  match "accounts/:service/:account" => "outlets#remove", :via => :delete, :as => :delete_outlet

  # API call /auth_tokens/request, GET and POST
  match "auth_tokens/request" => "auth_tokens#new", :via => :get, :as => :request_token
  match "auth_tokens/request" => "auth_tokens#create", :via => :post, :as => :create_token

  # API call /agencies, GET
  match "agencies" => "agencies#list", :via => :get, :as => :list_agencies

  # API call /services, GET
  match "services" => "services#list", :via => :get, :as => :list_services

  # API call /tags, GET
  match "tags" => "official_tags#list", :via => :get, :as => :list_tags
  
  # API call /locations/resolve, GET
  match "locations/resolve" => "outlet_locations#resolve", :via => :get, :as => :resolve_locations
  
  # HowTo.gov proxied style
  match "howto/register" => "howto#add", :via => :get, :as => :howto_add_outlet
  match "howto/register" => "howto#update", :via => :post, :as => :howto_update_outlet
  match "howto/remove"   => "howto#remove", :via => :post, :as => :howto_remove_outlet
  match "howto/find"     => "howto#verify", :via => :get, :as => :howto_find_outlet
  match "howto/request"  => "howto_tokens#new", :via => :get, :as => :howto_request_token
  match "howto/request"  => "howto_tokens#create", :via => :post, :as => :howto_create_token
  
  # HowTo.gov embedded style
  match "embed/find" => "embed#verify", :via => :get, :as => :embed_find_outlet
  match "embed/request" => "embed_tokens#new", :via => :get, :as => :embed_request_token
  match "embed/request" => "embed_tokens#create", :via => :post, :as => :embed_create_token
  
end
