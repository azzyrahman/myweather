Myweather::Application.routes.draw do

  devise_for :users
  
  #home
  root 'home#index'
  get '/home/about/' => 'home#about' , :as => 'about'  
  #location search
  post '/location/search' => 'weather#search' , :as => 'search'  
  #observation
  get '/weather/observation/:type/:code' => 'weather#observation' , :as => 'observation'  
  get '/weather/observation/' => 'home#index' , :as => 'observation_public'  
  #forecast
  get '/weather/forecast/:type/:code' => 'weather#forecast' , :as => 'forecast'  
  get '/weather/forecast/' => 'home#index' , :as => 'forecast_public'  
  #radar
  get '/weather/radar/:type/:code' => 'weather#local_radar' , :as => 'local_radar'  
  get '/weather/radar/' => 'weather#radar' , :as => 'radar'  
  #favourite locations
  get '/location/favourite/' => 'favourite_locations#list' , :as => 'favourite'  
  resources :favourite_locations , :only => [:destroy,:create]



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
