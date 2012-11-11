CustomerLoyalty::Application.routes.draw do
  devise_for :users, controllers: { registrations: 'UserRegistrations' }
  resources :users
  devise_scope :user do
    match 'merchant/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'merchant' }
    match 'customer/sign_up' => 'user_registrations#new', :user => { :rolable_type => 'customer' }
  end

  #get 'customer/:id/trackvisit' => 'customer#track_visit'
  get 'customer/:id/track_visit' => 'customer#track_visit', :as => 'loyalty_scan'
  get 'customer/:id/generate_passbook' => 'customer#generate_passbook'

  get 'merchant/:id/rewards_program' => 'merchant#rewards_program', :as => 'reward_program_details'
  put 'merchant/:id/rewards_program' => 'merchant#update_rewards_program', :as => 'update_reward_program'

  root :to => "home#index"
end
