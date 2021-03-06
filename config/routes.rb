Rails.application.routes.draw do
  get 'welcome/index'

  resources :folders, only: [:index, :show]

  namespace :dashboard do
    get '/' => "base#index"
    get 'base/index'
    resources :entities do
      member do
        patch :toggle_visible
      end
    end
    resources :folders
    resources :vendors do
      resources :materials
    end
    resources :materials
    resources :users do
      member do
        patch :toggle_visible
      end
    end
  end

  namespace :plugin do
    get '/' => 'base#index'
  end

  namespace :api, defaults: { format: :json } do
    resources :entities, only: [:index, :create, :destroy] do
      get :mine, on: :collection
    end

    resources :users, only: [:create] do
      post :login, on: :collection
      delete :sign_out, on: :collection
    end
  end


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
