StressMind::Application.routes.draw do

  devise_for :admins,     :controllers => { :sessions      => "admins/sessions",
                                            :registrations => "admins/registrations"}

  devise_for :therapists, :controllers => { :sessions      => "therapists/sessions", 
                                            :registrations => "therapists/registrations" }

  devise_for :users,      :controllers => { :registrations => "users/registrations" }

  devise_for :managers,   :controllers => { :sessions      => "managers/sessions",
                                            :registrations => "managers/registrations"  }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users/invitation_email#start_email'

  # Stress Test
  get  'stresstest'             => 'users/stress_test#show'
  post 'stresstest/feedback'    => 'users/stress_test#feedback'

  namespace :clients do
    get  'index'                => 'clients#index'
    get  'diaryboard'           => 'clients#diaryboard'
    get  'unapproved'           => 'clients#unapproved'
    get  'date/:date'           => 'clients#diaryboard'
    get  'articles'             => 'clients#articles'
    get  'statistics'           => 'clients#statistics'
    #get  'appointments'         => 'clients#appointments'
    get  'stress_test/:id'      => 'clients#stress_test'
    put  'profile'              => 'user_details#update'
  end 

  namespace :therapists do
    get  'index'                => 'therapists#index'
    get  'clients'              => 'therapists#clients'
    #get  'appointments'         => 'therapists#appointments'
    get  'client/:id'           => 'therapists#client'
    put  'client/:id/note'      => 'therapists#add_note'
    post 'client/:id/journal'   => 'journals#add_journal'
    post 'client/:id/diary/:diary_id/comment'    => 'therapists#add_diary_comment'
    put  'profile'              => 'therapist_details#update'
    post 'assign/:client_id'    => 'therapists#assign'
  end

  # diary
  get  'clients/:id/exercises.json'         => 'diaries/exercises#exercises'
  get  'clients/:id/sleeps.json'            => 'diaries/sleeps#sleeps'
  get  'clients/:id/stresses.json'          => 'diaries/stresses#stresses'
  get  'clients/:id/monthly_diaries.json'   => 'diaries/diaries#monthly_diaries'

  namespace :diaries do 
    get  '/'                 => 'diaries#diaries' 
    get  'sleeps.json'       => 'sleeps#sleeps'
    get  'exercises.json'    => 'exercises#exercises'
    get  'stresses.json'     => 'stresses#stresses'
    get  ':id'               => 'diaries#show'
    put  ':id'               => 'diaries#update_diary'
    post ':id/comment'       => 'diaries#add_comment'
  end

  namespace :admins do
    resources :articles
    resources :companies

    resources :companies do
      resources :departments
      resources :departments do
        resources :sections
      end
    end

    get  'index'               => 'admins#index'
    get  'clients'             => 'admins#clients'
    get  'therapists'          => 'admins#therapists'
    get  'therapist/:id'       => 'admins#therapist'
    get  'articles'            => 'articles#index'
    get  'companies'           => 'companies#index'
  end

  namespace :managers do
    get  'index'                    => 'managers#index'
    get  'invoices'                 => 'managers#invoices'
    get  'employees'                => 'managers#employees'
    put  'approve_employee/:id'     => 'managers#approve_employee'
    put  'reject_employee/:id'      => 'managers#reject_employee'
  end

  namespace :assignments do 
    get  'client_index'        => 'assignments#client_index'
    get  ':id'                 => 'assignments#show'
    put  ':id/save_type1'      => 'assignments#save_type1'
    put  ':id/submit'          => 'assignments#submit'
    post 'client/:id'          => 'assignments#assign'
  end

  post 'company/validate_code'  => 'admins/companies#validate_code'

  post 'users/send_invitation_email'  => 'users/invitation_email#send_invitation_email'
  get  'users/invitation_email_sent'  => 'users/invitation_email#invitation_email_sent'
  get  'users/test_expired'           => 'users/invitation_email#test_expired'

  # Error pages
  unless Rails.application.config.consider_all_requests_local
    get '*not_found' => 'errors#error_404'
  end

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
