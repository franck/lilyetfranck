ActionController::Routing::Routes.draw do |map|
  map.resources :gifts, :member => {
    :edit_pic => :get,
    :update_pic => :get
  }
  map.resources :albums
  map.resources :posts, :collection => {
    :rss => :get
  }


  #map.filter "locale"

  map.resource :user_session
  map.root :controller => "posts", :action => "index"
  
  map.admin "admin", :controller => "users"
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resource :account, :controller => "users"
  map.resources :users
  

end
