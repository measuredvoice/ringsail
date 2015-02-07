# == Route Map
#
#                                  Prefix Verb   URI Pattern                                                     Controller#Action
# social_media_breakdown_admin_dashboards GET    /admin/dashboards/social_media_breakdown(.:format)              admin/dashboards#social_media_breakdown
#             activities_admin_dashboards GET    /admin/dashboards/activities(.:format)                          admin/dashboards#activities
#                        admin_dashboards GET    /admin/dashboards(.:format)                                     admin/dashboards#index
#                                         POST   /admin/dashboards(.:format)                                     admin/dashboards#create
#                     new_admin_dashboard GET    /admin/dashboards/new(.:format)                                 admin/dashboards#new
#                    edit_admin_dashboard GET    /admin/dashboards/:id/edit(.:format)                            admin/dashboards#edit
#                         admin_dashboard GET    /admin/dashboards/:id(.:format)                                 admin/dashboards#show
#                                         PATCH  /admin/dashboards/:id(.:format)                                 admin/dashboards#update
#                                         PUT    /admin/dashboards/:id(.:format)                                 admin/dashboards#update
#                                         DELETE /admin/dashboards/:id(.:format)                                 admin/dashboards#destroy
#               tokeninput_admin_agencies GET    /admin/agencies/tokeninput(.:format)                            admin/agencies#tokeninput
#                    history_admin_agency GET    /admin/agencies/:id/history(.:format)                           admin/agencies#history
#                    restore_admin_agency GET    /admin/agencies/:id/restore(.:format)                           admin/agencies#restore
#               activities_admin_agencies GET    /admin/agencies/activities(.:format)                            admin/agencies#activities
#                          admin_agencies GET    /admin/agencies(.:format)                                       admin/agencies#index
#                                         POST   /admin/agencies(.:format)                                       admin/agencies#create
#                        new_admin_agency GET    /admin/agencies/new(.:format)                                   admin/agencies#new
#                       edit_admin_agency GET    /admin/agencies/:id/edit(.:format)                              admin/agencies#edit
#                            admin_agency GET    /admin/agencies/:id(.:format)                                   admin/agencies#show
#                                         PATCH  /admin/agencies/:id(.:format)                                   admin/agencies#update
#                                         PUT    /admin/agencies/:id(.:format)                                   admin/agencies#update
#                                         DELETE /admin/agencies/:id(.:format)                                   admin/agencies#destroy
#          tokeninput_admin_official_tags GET    /admin/official_tags/tokeninput(.:format)                       admin/official_tags#tokeninput
#              history_admin_official_tag GET    /admin/official_tags/:id/history(.:format)                      admin/official_tags#history
#              restore_admin_official_tag GET    /admin/official_tags/:id/restore(.:format)                      admin/official_tags#restore
#          activities_admin_official_tags GET    /admin/official_tags/activities(.:format)                       admin/official_tags#activities
#                     admin_official_tags GET    /admin/official_tags(.:format)                                  admin/official_tags#index
#                                         POST   /admin/official_tags(.:format)                                  admin/official_tags#create
#                  new_admin_official_tag GET    /admin/official_tags/new(.:format)                              admin/official_tags#new
#                 edit_admin_official_tag GET    /admin/official_tags/:id/edit(.:format)                         admin/official_tags#edit
#                      admin_official_tag GET    /admin/official_tags/:id(.:format)                              admin/official_tags#show
#                                         PATCH  /admin/official_tags/:id(.:format)                              admin/official_tags#update
#                                         PUT    /admin/official_tags/:id(.:format)                              admin/official_tags#update
#                                         DELETE /admin/official_tags/:id(.:format)                              admin/official_tags#destroy
#                    publish_admin_outlet GET    /admin/outlets/:id/publish(.:format)                            admin/outlets#publish
#                    archive_admin_outlet GET    /admin/outlets/:id/archive(.:format)                            admin/outlets#archive
#                datatables_admin_outlets GET    /admin/outlets/datatables(.:format)                             admin/outlets#datatables
#                    history_admin_outlet GET    /admin/outlets/:id/history(.:format)                            admin/outlets#history
#                    restore_admin_outlet GET    /admin/outlets/:id/restore(.:format)                            admin/outlets#restore
#                activities_admin_outlets GET    /admin/outlets/activities(.:format)                             admin/outlets#activities
#                           admin_outlets GET    /admin/outlets(.:format)                                        admin/outlets#index
#                                         POST   /admin/outlets(.:format)                                        admin/outlets#create
#                        new_admin_outlet GET    /admin/outlets/new(.:format)                                    admin/outlets#new
#                       edit_admin_outlet GET    /admin/outlets/:id/edit(.:format)                               admin/outlets#edit
#                            admin_outlet GET    /admin/outlets/:id(.:format)                                    admin/outlets#show
#                                         PATCH  /admin/outlets/:id(.:format)                                    admin/outlets#update
#                                         PUT    /admin/outlets/:id(.:format)                                    admin/outlets#update
#                                         DELETE /admin/outlets/:id(.:format)                                    admin/outlets#destroy
#                publish_admin_mobile_app GET    /admin/mobile_apps/:id/publish(.:format)                        admin/mobile_apps#publish
#                archive_admin_mobile_app GET    /admin/mobile_apps/:id/archive(.:format)                        admin/mobile_apps#archive
#            datatables_admin_mobile_apps GET    /admin/mobile_apps/datatables(.:format)                         admin/mobile_apps#datatables
#                history_admin_mobile_app GET    /admin/mobile_apps/:id/history(.:format)                        admin/mobile_apps#history
#                restore_admin_mobile_app GET    /admin/mobile_apps/:id/restore(.:format)                        admin/mobile_apps#restore
#            activities_admin_mobile_apps GET    /admin/mobile_apps/activities(.:format)                         admin/mobile_apps#activities
#                       admin_mobile_apps GET    /admin/mobile_apps(.:format)                                    admin/mobile_apps#index
#                                         POST   /admin/mobile_apps(.:format)                                    admin/mobile_apps#create
#                    new_admin_mobile_app GET    /admin/mobile_apps/new(.:format)                                admin/mobile_apps#new
#                   edit_admin_mobile_app GET    /admin/mobile_apps/:id/edit(.:format)                           admin/mobile_apps#edit
#                        admin_mobile_app GET    /admin/mobile_apps/:id(.:format)                                admin/mobile_apps#show
#                                         PATCH  /admin/mobile_apps/:id(.:format)                                admin/mobile_apps#update
#                                         PUT    /admin/mobile_apps/:id(.:format)                                admin/mobile_apps#update
#                                         DELETE /admin/mobile_apps/:id(.:format)                                admin/mobile_apps#destroy
#                   history_admin_gallery GET    /admin/galleries/:id/history(.:format)                          admin/galleries#history
#                   restore_admin_gallery GET    /admin/galleries/:id/restore(.:format)                          admin/galleries#restore
#              activities_admin_galleries GET    /admin/galleries/activities(.:format)                           admin/galleries#activities
#                         admin_galleries GET    /admin/galleries(.:format)                                      admin/galleries#index
#                                         POST   /admin/galleries(.:format)                                      admin/galleries#create
#                       new_admin_gallery GET    /admin/galleries/new(.:format)                                  admin/galleries#new
#                      edit_admin_gallery GET    /admin/galleries/:id/edit(.:format)                             admin/galleries#edit
#                           admin_gallery GET    /admin/galleries/:id(.:format)                                  admin/galleries#show
#                                         PATCH  /admin/galleries/:id(.:format)                                  admin/galleries#update
#                                         PUT    /admin/galleries/:id(.:format)                                  admin/galleries#update
#                                         DELETE /admin/galleries/:id(.:format)                                  admin/galleries#destroy
#                  tokeninput_admin_users GET    /admin/users/tokeninput(.:format)                               admin/users#tokeninput
#                             admin_users GET    /admin/users(.:format)                                          admin/users#index
#                                         POST   /admin/users(.:format)                                          admin/users#create
#                          new_admin_user GET    /admin/users/new(.:format)                                      admin/users#new
#                         edit_admin_user GET    /admin/users/:id/edit(.:format)                                 admin/users#edit
#                              admin_user GET    /admin/users/:id(.:format)                                      admin/users#show
#                                         PATCH  /admin/users/:id(.:format)                                      admin/users#update
#                                         PUT    /admin/users/:id(.:format)                                      admin/users#update
#                                         DELETE /admin/users/:id(.:format)                                      admin/users#destroy
#                    admin_email_messages GET    /admin/email_messages(.:format)                                 admin/email_messages#index
#                                         POST   /admin/email_messages(.:format)                                 admin/email_messages#create
#                 new_admin_email_message GET    /admin/email_messages/new(.:format)                             admin/email_messages#new
#                edit_admin_email_message GET    /admin/email_messages/:id/edit(.:format)                        admin/email_messages#edit
#                     admin_email_message GET    /admin/email_messages/:id(.:format)                             admin/email_messages#show
#                                         PATCH  /admin/email_messages/:id(.:format)                             admin/email_messages#update
#                                         PUT    /admin/email_messages/:id(.:format)                             admin/email_messages#update
#                                         DELETE /admin/email_messages/:id(.:format)                             admin/email_messages#destroy
#                             admin_about GET    /admin/about(.:format)                                          admin/admin#about
#                                   admin GET    /admin(.:format)                                                admin/dashboards#index
#                            user_service GET    /users/service(.:format)                                        devise/cas_sessions#service
#                    user_single_sign_out POST   /users/service(.:format)                                        devise/cas_sessions#single_sign_out
#                        new_user_session GET    /users/sign_in(.:format)                                        devise/cas_sessions#new
#               unregistered_user_session GET    /users/unregistered(.:format)                                   devise/cas_sessions#unregistered
#                            user_session POST   /users/sign_in(.:format)                                        devise/cas_sessions#create
#                    destroy_user_session GET    /users/sign_out(.:format)                                       devise/cas_sessions#destroy
#                         api_v1_agencies GET    /api/v1/agencies(.:format)                                      api/v1/agencies#index
#                           api_v1_agency GET    /api/v1/agencies/:id(.:format)                                  api/v1/agencies#show
#              verify_api_v1_social_media GET    /api/v1/social_media/verify(.:format)                           api/v1/social_media#verify
#            services_api_v1_social_media GET    /api/v1/social_media/services(.:format)                         api/v1/social_media#services
#          tokeninput_api_v1_social_media GET    /api/v1/social_media/tokeninput(.:format)                       api/v1/social_media#tokeninput
#                     api_v1_social_media GET    /api/v1/social_media(.:format)                                  api/v1/social_media#index
#                    api_v1_social_medium GET    /api/v1/social_media/:id(.:format)                              api/v1/social_media#show
#                        api_v1_galleries GET    /api/v1/galleries(.:format)                                     api/v1/galleries#index
#                          api_v1_gallery GET    /api/v1/galleries/:id(.:format)                                 api/v1/galleries#show
#           tokeninput_api_v1_mobile_apps GET    /api/v1/mobile_apps/tokeninput(.:format)                        api/v1/mobile_apps#tokeninput
#                      api_v1_mobile_apps GET    /api/v1/mobile_apps(.:format)                                   api/v1/mobile_apps#index
#                       api_v1_mobile_app GET    /api/v1/mobile_apps/:id(.:format)                               api/v1/mobile_apps#show
#                             api_v1_tags GET    /api/v1/tags(.:format)                                          api/v1/tags#index
#                              api_v1_tag GET    /api/v1/tags/:id(.:format)                                      api/v1/tags#show
#         autocomplete_api_v1_multi_index GET    /api/v1/multi/autocomplete(.:format)                            api/v1/multi#autocomplete
#           tokeninput_api_v1_multi_index GET    /api/v1/multi/tokeninput(.:format)                              api/v1/multi#tokeninput
#                      api_v1_multi_index GET    /api/v1/multi(.:format)                                         api/v1/multi#index
#                            api_v1_multi GET    /api/v1/multi/:id(.:format)                                     api/v1/multi#show
#                                         GET    /api/v1/agencies(.:format)                                      api/v1/agencies#index
#                                         GET    /api/v1/agencies/:id(.:format)                                  api/v1/agencies#show
#            autocomplete_public_agencies GET    /public/agencies/autocomplete(.:format)                         public/agencies#autocomplete
#                         public_agencies GET    /public/agencies(.:format)                                      public/agencies#index
#                                         POST   /public/agencies(.:format)                                      public/agencies#create
#                       new_public_agency GET    /public/agencies/new(.:format)                                  public/agencies#new
#                      edit_public_agency GET    /public/agencies/:id/edit(.:format)                             public/agencies#edit
#                           public_agency GET    /public/agencies/:id(.:format)                                  public/agencies#show
#                                         PATCH  /public/agencies/:id(.:format)                                  public/agencies#update
#                                         PUT    /public/agencies/:id(.:format)                                  public/agencies#update
#                                         DELETE /public/agencies/:id(.:format)                                  public/agencies#destroy
#                                    root GET    /                                                               public/home#index
#                           verify_outlet GET    /accounts/verify(.:format)                                      public/outlets#verify
#                             show_outlet GET    /accounts/:service/:account(.:format)                           public/outlets#verify {:account=>/[\w.@\+-]+?/, :format=>/html|json|xml/}
#                            list_outlets GET    /accounts(.:format)                                             public/outlets#list
#                    list_service_outlets GET    /accounts/:service_id(.:format)                                 public/outlets#list
#                              add_outlet GET    /accounts/register(.:format)                                    public/outlets#add
#                           update_outlet POST   /accounts/register(.:format)                                    public/outlets#update
#                           remove_outlet POST   /accounts/remove(.:format)                                      public/outlets#remove
#                           delete_outlet DELETE /accounts/:service/:account(.:format)                           public/outlets#remove {:account=>/[\w.@\+-]+?/, :format=>/html|json|xml/}
#                           request_token GET    /auth_tokens/request(.:format)                                  public/auth_tokens#new
#                            create_token POST   /auth_tokens/request(.:format)                                  public/auth_tokens#create
#                           list_agencies GET    /agencies(.:format)                                             public/agencies#list
#                           list_services GET    /services(.:format)                                             public/services#list
#                               list_tags GET    /tags(.:format)                                                 public/official_tags#list
#                       resolve_locations GET    /locations/resolve(.:format)                                    public/outlet_locations#resolve
#                        howto_add_outlet GET    /social-media/social-media-registry/accounts/register(.:format) public/howto#add
#                     howto_update_outlet POST   /social-media/social-media-registry/accounts/register(.:format) public/howto#update
#                     howto_remove_outlet POST   /social-media/social-media-registry/accounts/remove(.:format)   public/howto#remove
#                       howto_find_outlet GET    /social-media/social-media-registry/accounts/find(.:format)     public/howto#verify
#                    howto_review_outlets GET    /social-media/social-media-registry/accounts/review(.:format)   public/howto#review
#                    howto_confirm_outlet POST   /social-media/social-media-registry/accounts/confirm(.:format)  public/howto#confirm
#                     howto_request_token GET    /social-media/social-media-registry/accounts/request(.:format)  public/howto_tokens#new
#                      howto_create_token POST   /social-media/social-media-registry/accounts/request(.:format)  public/howto_tokens#create
#                         howto_list_tags GET    /social-media/social-media-registry/accounts/tags(.:format)     public/official_tags#list
#                    howto_browse_outlets GET    /social-media/social-media-registry/accounts/browse(.:format)   public/howto#browse
#                       embed_find_outlet GET    /embed/find(.:format)                                           public/embed#verify
#                     embed_request_token GET    /embed/request(.:format)                                        public/embed_tokens#new
#                      embed_create_token POST   /embed/request(.:format)                                        public/embed_tokens#create
#                    usagov_verify_outlet GET    /usagov/verify(.:format)                                        public/usagov#verify
#                  gobierno_verify_outlet GET    /gobierno/verificar(.:format)                                   public/gobierno#verify
#

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
    resources :outlets, concerns: :activity_and_history do
      member do
        get "publish"
        get "archive"
      end
      collection do
        get "datatables"
      end
    end
    resources :mobile_apps, concerns: :activity_and_history do
      member do
        get "publish"
        get "archive"
      end
      collection do
        get "datatables"
      end
    end
    resources :galleries, concerns: :activity_and_history
    resources :users do
      collection do
        get 'tokeninput'
      end
    end
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
      resources :social_media, only: [:index, :show] do
        collection do
          get 'verify'
          get 'services'
          get 'tokeninput'
        end
      end
      resources :galleries, only: [:index, :show]
      resources :mobile_apps, only: [:index, :show] do
        collection do
          get 'tokeninput'
        end
      end
      resources :tags, only: [:index, :show]
      resources :multi, only: [:index, :show] do
        collection do
          get 'autocomplete'
          get 'tokeninput'
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
