CustomerLoyalty::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'UserRegistrations' }
  devise_scope :users do
    match 'merchant/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'merchant' }
    match 'customer/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'customer' }
  end

  root :to => "home#index"
end
