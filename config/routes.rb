Rails.application.routes.draw do

  #match "/404", to: "errors#error404", via: [ :get, :post, :patch, :delete ]
  
  devise_for :users
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/indevelopment'
  get '/etorgy', to: 'static_pages#indevelopment'
  get '/untreatedwood', to: 'static_pages#untreated_wood'
  get '/download/propoz/:filename', to: "static_pages#download_propoz"
  get '/feedback/send_done', to: 'feedback#send_done'
  get '/torgy', to: 'static_pages#torgy'
 

  resources :result, only: [:index]
  resources :articles, only: [:index,:show]
  resources :pages, only: [:show]
  resources :feedback, only: [:create, :index]

  
  resources :auction, only: [:index,:show,:download] do
    member do
      get "download"
    end
  end

  get '/elfinder_manager', to: 'elfinder#index'
  match 'elfinder' => 'elfinder#elfinder', via: [:get, :post]

  namespace :admin do
    root 'pages#index'
    resources :articles
    resources :pages
    resources :status
    resources :category
    resources :auction do
      delete "file" => "auction#file_destroy"
    end
    resources :propoz
    resources :result
    resources :setting, only: [:index, :create]
    resources :users
  end
get "*any", via: :all, to: "errors#error404"
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
