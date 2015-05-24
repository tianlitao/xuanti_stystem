Rails.application.routes.draw do


  get 'student/index'

  get 'teacher/index'

  get 'users/welcome'

  get 'users/signup'

  get 'users/login'
  get 'student/choice_title', :as => 'choice_title'
  get 'student/confirm_title', :as => 'confirm_title'
  get 'student/upload_design', :as => 'upload_design'
  get 'student/delete_upload' , :as => 'delete_upload'
  get 'users/message' ,:as => 'message'
  get 'teacher/check' ,:as => 'check'
  post 'upload' => 'student#upload'
  post 'teacher_upload' => 'teacher#teacher_upload'


  get 'teacher/add_title' => 'teacher#add_title', :as => 'add_title'
  root to: "users#login"
  get "login" => "users#login", :as => "login"
  get "signup" => "users#signup", :as => "signup"
  post "create_login_session" => "users#create_login_session"
  delete "logout" => "users#logout", :as => "logout"
  resources :users, :designs, :messages, only: [:create]
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
