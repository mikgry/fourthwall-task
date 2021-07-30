Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :internal do
    namespace :v1 do
      resources :movies, only: %i(update)
    end
  end
end
