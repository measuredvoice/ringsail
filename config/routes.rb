Ringsail::Application.routes.draw do
  
  # This calls should all be namespaced to admin, we should move away from railsadmin
  resources :agencies do
    collection do
      get "autocomplete"
    end
  end



  # match "admin/previews/review_email" => "previews#review_email", :via => :get, :as => :preview_review_email
  # match "admin/previews/review_email/send" => "previews#send_review_email", :via => :post, :as => :preview_send_review_email
  
  # we are going to replace rails admin, its not very maintainable, but a decent crud
  # keep in the app until we are sure we've replace the functionality
  #mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  namespace :admin do
    resources :dashboards do
      collection do
        get 'social_media_breakdown' => 'dashboards#social_media_breakdown'
        get 'activities' => 'dashboards#activities'
      end
    end
    resources :agencies do
      member do
        get "history"
      end
      collection do
        get "activities"
      end
    end

    resources :outlets do
      member do
        get "history"
        get "restore"
      end
      collection do 
        get "activities"
      end
    end

    resources :mobile_apps do
      member do
        get "history"
        get "restore"
      end
      collection do 
        get "activities"
      end
    end

    resources :galleries do
      member do
        get "history"
        get "restore"
      end
      collection do 
        get "activities"
      end
    end
    resources :users

    get '/' => 'dashboards#index'
  end
  devise_for :users
  
  root :to => "home#index"



  ######
  # THESE ARE CURRENTLY EXISTING API CALLS
  ######
  # API call /accounts/verify, GET
  # and synonym /accounts/{service}/{account}, GET
  match "accounts/verify" => "outlets#verify", :via => :get, :as => :verify_outlet
  match "accounts/:service/:account" => "outlets#verify", :via => :get, :as => :show_outlet, :constraints => {:account => /[\w.@\+-]+?/, :format => /html|json|xml/}
  
  # API call /accounts, GET
  # and synonym /accounts/{service}, GET
  match "accounts" => "outlets#list", :via => :get, :as => :list_outlets
  match "accounts/:service_id" => "outlets#list", :via => :get, :as => :list_service_outlets

  # API call /outlets/register, both GET and POST
  match "accounts/register" => "outlets#add", :via => :get, :as => :add_outlet
  match "accounts/register" => "outlets#update", :via => :post, :as => :update_outlet
  
  # API call /outlets/remove, either DELETE or POST
  match "accounts/remove" => "outlets#remove", :via => :post, :as => :remove_outlet
  match "accounts/:service/:account" => "outlets#remove", :via => :delete, :as => :delete_outlet, :constraints => {:account => /[\w.@\+-]+?/, :format => /html|json|xml/}

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
  

  ######
  # THESE ARE CURRENTLY EMBEDDED PAGES. IF WE REPLACE THE CURRENT APP, WE MUST KEEP THIS OPERATIONAL
  ######
  # HowTo.gov proxied style
  match "social-media/social-media-registry/accounts/register" => "howto#add", :via => :get, :as => :howto_add_outlet
  match "social-media/social-media-registry/accounts/register" => "howto#update", :via => :post, :as => :howto_update_outlet
  match "social-media/social-media-registry/accounts/remove"   => "howto#remove", :via => :post, :as => :howto_remove_outlet
  match "social-media/social-media-registry/accounts/find"     => "howto#verify", :via => :get, :as => :howto_find_outlet
  match "social-media/social-media-registry/accounts/review"     => "howto#review", :via => :get, :as => :howto_review_outlets
  match "social-media/social-media-registry/accounts/confirm" => "howto#confirm", :via => :post, :as => :howto_confirm_outlet
  match "social-media/social-media-registry/accounts/request"  => "howto_tokens#new", :via => :get, :as => :howto_request_token
  match "social-media/social-media-registry/accounts/request"  => "howto_tokens#create", :via => :post, :as => :howto_create_token
  match "social-media/social-media-registry/accounts/tags" => "official_tags#list", :via => :get, :as => :howto_list_tags
  match "social-media/social-media-registry/accounts/browse"     => "howto#browse", :via => :get, :as => :howto_browse_outlets
  
  # HowTo.gov embedded style
  match "embed/find" => "embed#verify", :via => :get, :as => :embed_find_outlet
  match "embed/request" => "embed_tokens#new", :via => :get, :as => :embed_request_token
  match "embed/request" => "embed_tokens#create", :via => :post, :as => :embed_create_token
  
  # USA.gov embedded style
  match "usagov/verify" => "usagov#verify", :via => :get, :as => :usagov_verify_outlet
  
  # GobiernoUSA.gov embedded style
  match "gobierno/verificar" => "gobierno#verify", :via => :get, :as => :gobierno_verify_outlet

end
