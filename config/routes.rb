# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'api/auth', skip: [:omniauth_callbacks]
  namespace :api, defaults: { format: :json } do
    resources :teams, only: %i[index create update show]
    resources :players, only: [:show]
    resources :trainings, only: %i[create index]
    resources :seasons, only: %i[create show]
  end
end
