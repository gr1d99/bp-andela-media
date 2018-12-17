Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :user_groups, only: [:create]
  end
  resources :albums, only: :create
end
