class FrontendController < ApplicationController
    include FrontendHelper

    def home
        redirect_to '/frontend/dashboard'
    end

    def show
        @testa = '传递测试1'
        @testb = '传递测试2'
    end

    def courses
        certer = Certer.new("Milky2020", "lzy19980424")
        spider = Spider.new("leizhengyu16@mails.ucas.ac.cn", "lzy19980424", :chrome, certer)
        spider.login_sep 
        @courses = spider.get_courses 
        spider.quit 
    end 
end
