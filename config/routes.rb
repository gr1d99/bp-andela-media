Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :user_groups, only: %i[create show index update destroy]
    resources :albums, only: %i[index create update destroy]
    resources :centers, only: %i[index]
  end
end
