Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :user_groups, only: %i[create show index destroy]
  end
  resources :albums, only: %i[create update destroy]
end
