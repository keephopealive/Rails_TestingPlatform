Rails.application.routes.draw do
  root to: 'tests#index'
  post '/updateTestDescription' => 'admintests#updateTestDescription'
  post '/updateTestNameUrl' => 'admintests#updateTestNameUrl'
  post '/addQuestion' => 'admintests#addQuestion'
  post '/deleteQuestion' => 'admintests#deleteQuestion'
  post '/addAnswer' => 'admintests#addAnswer'
  post '/deleteAnswer' => 'admintests#deleteAnswer'
  post '/saveQuestion' => 'admintests#saveQuestion'
  post '/updateQuestionTimer' => 'admintests#updateQuestionTimer'
  post '/updateAnswer' => 'admintests#updateAnswer'
  post '/updateAnswerTrueFalse' => 'admintests#updateAnswerTrueFalse'
  post '/updateAnswerTimeLimit' => 'admintests#updateAnswerTimeLimit'
  get '/admintests' => 'admintests#index'

  post '/admintests/new' => 'admintests#new'

  get '/admintests/edit/:id' => 'admintests#edit'
  get 'admintests/show' => 'admintests#show'

  post '/tests' => 'tests#create'
  get '/tests/pretest' => 'tests#pretest'
  get '/tests/:id/pretest' => 'tests#pretest'
  get '/tests/new/:id' => 'tests#new'
  post '/getXML' => 'admintests#xmlContent'
  get 'admintests/newShow' => 'admintests#newShow'
  post '/results' => 'tests#results'

  # AJAX 
  post '/search/name' => 'admintests#getNames'
  # get '/search/name'  => 'admintests#getNames'
  post '/search/email' => 'admintests#getEmails'
  # get '/search/email' => 'admintests#getEmails'
  # //http://localhost:3000/tests/new/277   tests/277/pretest
  get '/tests/:id/pretest' => 'tests#pretest'


  resources :tests, :users, :sessions, :admintests
  get '/logout' => 'sessions#destroy'

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
