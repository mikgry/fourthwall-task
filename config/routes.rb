Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :internal do
    namespace :v1 do
      resources :movies, only: %i(update) do
        resources :movie_times, only: %i(create destroy)
      end
    end
  end
end
