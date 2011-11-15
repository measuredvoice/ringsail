Ringsail::Application.routes.draw do

  # API call /outlets/add, both GET and POST
  match "outlets/add" => "outlets#add", :via => :get, :as => :add
  match "outlets/add" => "outlets#update", :via => :post, :as => :update
  
  # API call /outlets/remove, DELETE or POST
  match "outlets/:service/:account" => "outlets#destroy", :via => :delete, :as => :destroy
  match "outlets/remove" => "outlets#remove", :via => :post, :as => :remove

  # API call /outlets/verify
  match "outlets/verify" => "outlets#verify", :via => :get, :as => :verify
  match "outlets/:service/:account" => "outlets#show", :via => :get, :as => :show

end
