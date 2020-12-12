Rails.application.routes.draw do
    root 'frontend#home'
    resources :tasks
    get 'app/*path', to: 'frontend#show'
end
