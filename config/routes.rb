CustomerLoyalty::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'UserRegistrations' }
  resources :users
  devise_scope :user do
    match 'merchant/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'merchant' }
    match 'customer/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'customer' }
  end

  get 'customer/:id/generate_passbook' => 'customer#generate_passbook'

  get 'merchant/:id/rewards_program' => 'merchant#rewards_program', :as => 'reward_program_details'
  put 'merchant/:id/rewards_program' => 'merchant#update_rewards_program', :as => 'update_reward_program'
  get 'merchant/loyalty_scan/:id' => 'merchant#loyalty_scan', :as => 'loyalty_scan'
  post 'merchant/earn' => 'merchant#earn', :as => 'earn'

  root :to => "home#index"
end
