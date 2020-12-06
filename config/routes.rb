Rails.application.routes.draw do
    root 'frontend#home'
    get 'frontend/*path', to: 'frontend#show'
end
