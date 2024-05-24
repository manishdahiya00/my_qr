Rails.application.routes.draw do

  root "main#index"

  get "/admin" => "admin/login#new"
  post "/admin" => "admin/login#login"
  delete "/admin/logout" => "admin/login#logout"
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
      root to: "device_details#index"
  end

  mount API::Base => "/"

end
