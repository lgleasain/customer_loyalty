CustomerLoyalty::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'UserRegistrations' }
  resources :users
  devise_scope :user do
    match 'merchant/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'merchant' }
    match 'customer/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'customer' }
  end

  root :to => "home#index"
end
