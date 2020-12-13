module CourseSpider
  include SpiderBase

  SAKAI_URL = SEP_URL + '/portal/site/16/801'

  def get_courses
    @dr.get SEP_URL
    @dr.get SAKAI_URL

    @dr.find_element(:id, "loginUser").click

    begin
      @dr.find_element(:xpath, "//*[contains(@href,'anotherUser')]").click
    rescue Selenium::WebDriver::Error::NoSuchElementError => e

    ensure

    end

    find_data_site_id = /(\d{6})/

    return @dr.find_elements(:class, "site-favorite-btn").map do |elem|
      elem.attribute("data-site-id")
    end.select do |site|
      site =~ find_data_site_id
    end
  end
end
