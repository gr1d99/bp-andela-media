Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :user_groups, only: %i[create show index update destroy]
  end
  resources :albums, only: %i[create index update destroy]
end
