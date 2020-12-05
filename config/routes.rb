Rails.application.routes.draw do
    root 'dashboard#show'
    get 'lecture_info', to: 'lecture_info#show'
end
