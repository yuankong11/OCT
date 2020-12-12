Rails.application.routes.draw do
    root 'frontend#home'
    get 'app/*path', to: 'frontend#show'
end
