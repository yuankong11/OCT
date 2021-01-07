module TimetableSpider
  include SpiderBase

  def generate_ical
    if logged_in?

    else
      return :false
    end
  end
