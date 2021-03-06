Rails.application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  resources :events do
    resources :shifts
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
  }

  resources :issues
  resources :skills

  root 'application#index'

  get 'events/:event_id/shifts/:id/view_users' => 'shifts#view_users', as: 'shift_viewUsers'
  get 'events/:event_id/shifts/:id/remove/:user_id' => 'shifts#remove_user', as: 'shift_removeUser'

  get 'event/:id/duplicate' => 'events#duplicate'
  post 'event/:id/transfer' => 'events#transfer'

  get '/user/join_shift/:id/' => 'users#join_shift'
  get '/user/leave_shift/:id' => 'users#leave_shift'

  get '/user_activity' => 'user_activities#show'
  delete '/user_activity/:id' => 'user_activities#delete', as: 'delete_notification'
end
