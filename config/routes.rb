Rails.application.routes.draw do
  resources :invitations, :locations
  resources :groups do
    member do
      get :near_people
      put :arrive
    end
  end

  post 'api/subscription', controller: 'api', action: 'subscription'
  get 'api/send_notification', controller: 'api', action: 'notify_friends'

  devise_for :users

  resources :users do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  root to: redirect('/users/sign_in')
end
