AnchoDeMarca::Application.routes.draw do
  
  devise_for :users,:controllers => {:sessions => 'sessions',:passwords => "passwords",:confirmations => "confirmations"}
  devise_scope :user do
    get "sign_out", :to => "devise/sessions#destroy",:as => "logout"
  end

  resources :users do
    collection do
      get :client
      post :create_client
      get :creative
      post :create_creative
      get :tutor
      post :create_tutor
      get :visitor
      post :create_visitor
      get :creative_reputation
      get :tutor_reputation
      get :add_cities
    end
    resources :user_comments do
      collection do
        get :user_comments
      end
    end
  end
  
  resources :ratings

  resources :constants do
    member do
      post :recommender
      post :visitor_count
      post :vote
      post :bid_status
      post :user_view
      post :like
      post :project_recommender
      post :course_recommender
      post :like_proposal
      post :course_like
      post :participate_course
    end
    collection do
      get :project_views
      get :budget
      get :categories
      get :social_categories
      get :course_categories
      get :course_date
      get :project_date
      get :client_logos
      get :company
    end
  end

  resources :searches do
    collection do
      get :search
    end
  end


  root :to => "home#index"
  resources :home do
    collection do
      get :about_us
      get :how_it_works
      get :benifits_of_am
      get :our_services
      get :search
    end
    member do
      get :client_categories
      get :creative_categories
      get :tutor_categories
    end
  end

  resources :creative_folios

  resources :clients do
    member do
      put :update_client
    end
    collection do
      get :views
      get :categories
      get :clients
    end
  end
  resources :creatives do
    member do
      put :update_creative
    end
    collection do
      get :views
      get :categories
      get :creatives
      get :likes
    end
  end
  resources :tutors do
    member do
      put :update_tutor
    end
    collection do
      get :views
      get :categories
      get :tutors
    end
  end
  resources :visitors do
    member do
      put :update_visitor
    end
    collection do
      get :visitors
    end
  end

  resources :projects do
    member do
      post :visitor_count
      get :client_projects
      get :get_project
    end
    resources :images
    resources :bids do
      resources :comments
    end
    resources :project_comments
  end
  resources :categories
  resources :courses do
    member do
      get :tutor_courses
      get :get_course
    end
    resources :course_comments
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end