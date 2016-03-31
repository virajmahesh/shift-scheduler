Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :events do
    resources :shifts
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  root 'application#index'

  get '/user/join_shift/:id/' => 'users#join_shift'
  get '/user/leave_shift/:id' => 'users#leave_shift'
  get '/user_activity' => 'user_activities#show'
  get '/autocomplete/:partial_text' => 'roles#orderRoles'

end
