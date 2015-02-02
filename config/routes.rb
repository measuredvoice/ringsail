Ringsail::Application.routes.draw do

  # match "admin/previews/review_email" => "previews#review_email", :via => :get, :as => :preview_review_email
  # match "admin/previews/review_email/send" => "previews#send_review_email", :via => :post, :as => :preview_send_review_email
  
  # we are going to replace rails admin, its not very maintainable, but a decent crud
  # keep in the app until we are sure we've replace the functionality
  

  #######
  #### Admin Endpoints
  #######

  concern :activity_and_history do
    member do
      get "history"
      get "restore"
    end
    collection do
      get "activities"
    end
  end

  namespace :admin do
    resources :dashboards do
      collection do
        get 'social_media_breakdown' => 'dashboards#social_media_breakdown'
        get 'activities' => 'dashboards#activities'
      end
    end
    resources :agencies, concerns: :activity_and_history do
      collection do
        get 'tokeninput'
      end
    end
    resources :official_tags, concerns: :activity_and_history do
      collection do
        get 'tokeninput'
      end
    end
    resources :outlets, concerns: :activity_and_history
    resources :mobile_apps, concerns: :activity_and_history
    resources :galleries, concerns: :activity_and_history
    resources :users
    resources :email_messages

    get 'about' => 'admin#about'
    get '/' => 'dashboards#index'
  end
  devise_for :users

  #######
  #### API ENDPOINTS
  #######
  namespace :api do 
    namespace :v1 do
      resources :agencies, only: [:index, :show]
      resources :outlets, only: [:index, :show]
      resources :galleries, only: [:index, :show]
      resources :mobile_apps, only: [:index, :show]
      resources :official_tags, only: [:index, :show]
      resources :multi, only: [:index, :show] do
        collection do
          get 'autocomplete'
        end
      end
      resources :agencies, only: [:index, :show]
    end
  end
  

  #######
  #### PUBLIC PAGES
  #######
  namespace :public do
    resources :agencies do
      collection do
        get "autocomplete"
      end
    end
  end

  root :to => "public/home#index"


  ######
  # THESE ARE CURRENTLY EXISTING API CALLS
  ######
  # API call /accounts/verify, GET
  # and synonym /accounts/{service}/{account}, GET
  match "accounts/verify" => "public/outlets#verify", :via => :get, :as => :verify_outlet
  match "accounts/:service/:account" => "public/outlets#verify", :via => :get, :as => :show_outlet, :constraints => {:account => /[\w.@\+-]+?/, :format => /html|json|xml/}
  
  # API call /accounts, GET
  # and synonym /accounts/{service}, GET
  match "accounts" => "public/outlets#list", :via => :get, :as => :list_outlets
  match "accounts/:service_id" => "public/outlets#list", :via => :get, :as => :list_service_outlets

  # API call /outlets/register, both GET and POST
  match "accounts/register" => "public/outlets#add", :via => :get, :as => :add_outlet
  match "accounts/register" => "public/outlets#update", :via => :post, :as => :update_outlet
  
  # API call /outlets/remove, either DELETE or POST
  match "accounts/remove" => "public/outlets#remove", :via => :post, :as => :remove_outlet
  match "accounts/:service/:account" => "public/outlets#remove", :via => :delete, :as => :delete_outlet, :constraints => {:account => /[\w.@\+-]+?/, :format => /html|json|xml/}

  # API call /auth_tokens/request, GET and POST
  match "auth_tokens/request" => "public/auth_tokens#new", :via => :get, :as => :request_token
  match "auth_tokens/request" => "public/auth_tokens#create", :via => :post, :as => :create_token

  # API call /agencies, GET
  match "agencies" => "public/agencies#list", :via => :get, :as => :list_agencies

  # API call /services, GET
  match "services" => "public/services#list", :via => :get, :as => :list_services

  # API call /tags, GET
  match "tags" => "public/official_tags#list", :via => :get, :as => :list_tags
  
  # API call /locations/resolve, GET
  match "locations/resolve" => "public/outlet_locations#resolve", :via => :get, :as => :resolve_locations
  

  ######
  # THESE ARE CURRENTLY EMBEDDED PAGES. IF WE REPLACE THE CURRENT APP, WE MUST KEEP THIS OPERATIONAL
  ######
  # HowTo.gov proxied style
  match "social-media/social-media-registry/accounts/register" => "public/howto#add", :via => :get, :as => :howto_add_outlet
  match "social-media/social-media-registry/accounts/register" => "public/howto#update", :via => :post, :as => :howto_update_outlet
  match "social-media/social-media-registry/accounts/remove"   => "public/howto#remove", :via => :post, :as => :howto_remove_outlet
  match "social-media/social-media-registry/accounts/find"     => "public/howto#verify", :via => :get, :as => :howto_find_outlet
  match "social-media/social-media-registry/accounts/review"     => "public/howto#review", :via => :get, :as => :howto_review_outlets
  match "social-media/social-media-registry/accounts/confirm" => "public/howto#confirm", :via => :post, :as => :howto_confirm_outlet
  match "social-media/social-media-registry/accounts/request"  => "public/howto_tokens#new", :via => :get, :as => :howto_request_token
  match "social-media/social-media-registry/accounts/request"  => "public/howto_tokens#create", :via => :post, :as => :howto_create_token
  match "social-media/social-media-registry/accounts/tags" => "public/official_tags#list", :via => :get, :as => :howto_list_tags
  match "social-media/social-media-registry/accounts/browse"     => "public/howto#browse", :via => :get, :as => :howto_browse_outlets
  
  # HowTo.gov embedded style
  match "embed/find" => "public/embed#verify", :via => :get, :as => :embed_find_outlet
  match "embed/request" => "public/embed_tokens#new", :via => :get, :as => :embed_request_token
  match "embed/request" => "public/embed_tokens#create", :via => :post, :as => :embed_create_token
  
  # USA.gov embedded style
  match "usagov/verify" => "public/usagov#verify", :via => :get, :as => :usagov_verify_outlet
  
  # GobiernoUSA.gov embedded style
  match "gobierno/verificar" => "public/gobierno#verify", :via => :get, :as => :gobierno_verify_outlet

end
