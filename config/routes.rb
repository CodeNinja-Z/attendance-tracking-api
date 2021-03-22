Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'authentication#authenticate'
      post 'signup', to: 'users#create'

      resources :attendance_logs, only: %i[index create update destroy]

      root "attendance_logs#index"
    end
  end
end
