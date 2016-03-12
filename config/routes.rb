Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :events
  resources :shifts

  root 'application#index'

  get 'signup' => 'user#new'
  post 'signup' => 'user#create'

  get 'user/join_shift/:id/' => 'user#join_shift'
  get 'user/leave_shift/:id' => 'user#leave_shift'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  
  delete 'logout' => 'sessions#destroy'

end
