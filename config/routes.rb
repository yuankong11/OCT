Rails.application.routes.draw do
    root 'frontend#home'
    get 'frontend/*path', to: 'frontend#show'

    # Temporary deal, routing any vue page to dashboard
    get 'app/*path', to: 'frontend#show'
end
