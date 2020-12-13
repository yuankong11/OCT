Rails.application.routes.draw do
    root 'frontend#home'
    resources :tasks
    get 'app/:postfix', to: 'frontend#show'
    get '*path', to: 'frontend#home'
end
