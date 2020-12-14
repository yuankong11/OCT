module FrontendHelper
  class Certer
    require 'http'

    TT_URL = 'http://api.ttshitu.com/base64'

    def initialize(username, password)
      @username = username
      @password = password
    end

    def get_code(image_url)
      base64 = image_to_base64(image_url, "png", false)
      data = {
        "username": @username,
        "password": @password,
        "image": base64,
        "typeid": 1001
      }

      response = HTTP.post(TT_URL, :json => data)
      return JSON.parse(response.body)["data"]["result"]
    end

    def image_to_base64(image_url, format, has_head)
      tempfile = open(image_url)
      if has_head
        head = 'data:image/' + format + ';base64,'
      elsif
        head = ''
      end
      image_base64 = Base64.encode64(File.read(tempfile))
      tempfile.close
      return (head + image_base64).delete("\n")
    end
  end

  class Spider
    require 'selenium-webdriver'
    require 'mini_magick'

    SEP_URL = 'http://sep.ucas.ac.cn'
    SAKAI_URL = SEP_URL + '/portal/site/16/801'
    APPSTORE_URL = SEP_URL + '/appStore'
    IMAGE_PATH = './app/assets/images/'

    attr_accessor :screenshot_path, :certcode_path

    def initialize(username, password, browser, certer)
      @postfix = (rand * 100).to_i.to_s
      @username = username
      @password = password
      @certer = certer
      @screenshot_path = IMAGE_PATH + 'screenshot' + @postfix + '.png'
      @certcode_path = IMAGE_PATH + 'certcode' + @postfix + '.png'

      options = Selenium::WebDriver::Chrome::Options.new
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
      options.headless!

      @dr = Selenium::WebDriver.for(browser, options: options)
      @dr.manage.window.maximize
    end

    def login_sep
      @dr.get SEP_URL

      @dr.find_element(:id, "userName").send_key(@username)
      @dr.find_element(:id, "pwd").send_key(@password)

      if need_certcode?
        cert_img = @dr.find_element(:id, "code")
        geo = img_location_str(cert_img)
        @dr.save_screenshot(@screenshot_path)
        @screenshot_saved = true
        shave(@screenshot_path, @certcode_path, geo)
        code = @certer.get_code(@certcode_path)

        @dr.find_element(:xpath, "//*[contains(@name, 'certCode')]").send_key(code)
      end

      @dr.find_element(:id, "sb").click

      return login_status
    end

    def need_certcode?
      begin
        @dr.find_element(:xpath, "//*[contains(@name, 'certCode')]")
        need = true
      rescue Selenium::WebDriver::Error::NoSuchElementError => e
        need = false
      ensure

      end
      return need
    end

    def logout
      if login_status == :success
        @dr.get APPSTORE_URL
        @dr.find_element(:class, "icon-off").click
        return :success
      else
        return :not_login_yet
      end
    end

    def login_status
      if @dr.current_url =~ /appStore/
        return :success
      else
        begin
          error_message = @dr.find_element(:class, "alert-error").text
        rescue Selenium::WebDriver::Error::NoSuchElementError => e
          error_message = :not_login_yet
        ensure

        end
        return error_message
      end
    end

    def quit
      logout
      @dr.quit
      if @screenshot_saved
        File.delete(@screenshot_path)
      end
      if @cert_saved
        File.delete(@certcode_path)
      end
    end

    def img_location_str(img_element)
      location = img_element.location
      size = img_element.size
      width = size.width.to_i * 2
      height = size.height.to_i * 2
      x = location.x.to_i * 2
      y = location.y.to_i * 2
      return "#{width}x#{height}+#{x}+#{y}"
    end

    def shave(input, output, geo)
      img = MiniMagick::Image.open(input)
      img.crop(geo)
      img.write(output)
      @cert_saved = true
    end

    include CourseSpider
    include ResourceSpider
    include LiveLessonSpider
    include LectureSpider
  end
end
