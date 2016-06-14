Rails.application.routes.draw do
  get 'admin' => 'admin#index'

  post 'search' => 'search#simple'

  root 'tickets#index'
  
  devise_for :users
  
  resources :users, only: [:show, :edit, :update]
  
  resources :user_rights
    
  resources :printers do
    resources :hardware_events
    member do
      get :watch
    end
  end

  resources :robotics do
    resources :hardware_events
    member do
      get :watch
    end
  end
    
  resources :controller_pcs do
    resources :hardware_events
    member do
      get :watch
    end
  end
  
  resources :hardware
    
  resources :devices do
    resources :device_licenses, only: [:new, :create]
    resources :device_events
    resources :device_interfaces, only: [:new, :create]
    resources :device_connections, only: [:new, :create]
    resources :contracts, only: [:new, :create]
    resources :addresses, only: [:new, :create]
    resources :tickets, only: [:new, :create]
    resources :upgrades, only: [:new, :create] do
      collection do
        get :addresssearch
      end
    end
    resources :builds, only: [:new, :create] do
      collection do
        get :addresssearch
      end
    end
    member do
      get :watch
      get :eventlog
    end
  end
  
  resources :umbrellas
  
  resources :customers do
    resources :customer_events
    resources :contacts, only: [:new, :create]
    resources :devices, only: [:new, :create]
    resources :addresses, only: [:new, :create]
    member do
      get :watch
    end
  end
  
  resources :contacts do
    resources :contact_events
    resources :addresses, only: [:new, :create]
    member do
      get :watch
    end
  end

  resources :rmas do
    resources :rma_events
    member do
      get :watch
      get :print
    end
  end

  resources :tickets do
    resources :ticket_events
    resources :rmas, only: [:new, :create] do
      collection do
        get :addresssearch
      end
    end
    member do
      get :move
      get :watch
    end
    collection do
      get :devicesearch
    end
  end

  resources :upgrades do
    resources :upgrade_events
    member do
      get :watch
      get :print
    end
  end
    
  resources :builds do
    resources :build_events
    member do
      get :watch
      get :print
    end
  end
          
  resources :bugs do
    resources :bug_notes
    member do
      get :watch
    end
  end
    
  resources :addresses
  
  resources :dropdowns
  
  resources :watches
  
  resources :user_notifications
  
  resources :version_notes

  resources :inventories
  
  resources :device_licenses
  
  resources :device_interfaces
  
  resources :device_connections
  
  resources :contracts
  
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
