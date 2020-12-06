class FrontendController < ApplicationController
    def home
        redirect_to '/frontend/dashboard'
    end

    def show
        @testa = '传递测试1'
        @testb = '传递测试2'
    end
end
