Rails.application.routes.draw do

  root "main#index"
  get "/invite/:refCode" => "main#invite"
  
  get "/admin" => "admin/login#new"
  post "/admin" => "admin/login#login"
  delete "/admin/logout" => "admin/login#logout"
  get "/admin/dashboard" => "admin/dashboard#index"  
  namespace :admin do
      resources :app_banners
      resources :app_opens
      resources :device_details
      resources :favourites
      resources :generated_qrs
      resources :qr_data
      resources :recently_addeds
      resources :redeems
      resources :redeem_histories
      resources :user_details
      get '/search-user' => 'user_details#index'
      get '/search-device' => 'device_details#index'
  end

  mount API::Base => "/"

end
