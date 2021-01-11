module LectureSpider
  include SpiderBase

  def get_science_lecture_info
    get_lecture_info
    @lecture[0]
  end

  def get_humanity_lecture_info
    get_lecture_info
    @lecture[1]
  end
end
