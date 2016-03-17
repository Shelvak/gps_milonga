Rails.application.routes.draw do
  resources :invitations, :locations
  resources :groups do
    get :near_people, on: :member
  end

  devise_for :users

  resources :users do
    member do
      get :edit_profile
      patch :update_profile
    end
  end

  root to: redirect('/users/sign_in')
end
