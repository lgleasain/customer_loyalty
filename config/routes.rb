CustomerLoyalty::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'UserRegistrations' }
  resources :users
  devise_scope :user do
    match 'merchant/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'merchant' }
    match 'customer/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'customer' }
  end

  get 'customer/:id/generate_passbook' => 'customer#generate_passbook', :as => 'generate_passbook'
  match "/customer/:id" => "customer#show", :as => 'customer_dashboard'

  get 'merchant/:id/rewards_program' => 'merchant#rewards_program', :as => 'reward_program_details'
  put 'merchant/:id/rewards_program' => 'merchant#update_rewards_program', :as => 'update_reward_program'
  get 'merchant/print_signup_page' => 'merchant#print_signup_page', :as => 'print_signup_page'
  get 'merchant/loyalty_scan/:id' => 'merchant#loyalty_scan', :as => 'loyalty_scan'
  post 'merchant/earn' => 'merchant#earn', :as => 'earn'
  post 'merchant/redeem' => 'merchant#redeem', :as => 'redeem'

  root :to => "home#index"
end
