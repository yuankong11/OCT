class FrontendController < ApplicationController
    def home
        redirect_to '/frontend/dashboard'
    end
end
