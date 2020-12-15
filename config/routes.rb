Rails.application.routes.draw do
  root 'frontend#home'
  resources :tasks
  get 'app/:postfix', to: 'frontend#show'
  get 'api/:function', to: 'api#function_dispatch'
  put 'api/:function', to: 'api#function_dispatch'
  get '*path', to: 'frontend#home'
end
