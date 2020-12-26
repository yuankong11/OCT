module SpiderBase
  # include 该模块以扩充 Spider 的功能，子模块中可以使用实例变量 @agent 以获取 Mechanize 对象
  HEADER = {
    'Connection' => 'keep-alive',
    'sec-ch-ua' => '"Google Chrome";v="87", "\\"Not;A\\\\Brand";v="99", "Chromium";v="87"',
    'Accept' => '*/*',
    'X-Requested-With' => 'XMLHttpRequest',
    'sec-ch-ua-mobile' => '?0',
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.67 Safari/537.36',
    'Content-Type' => 'application/x-www-form-urlencoded; charset=UTF-8',
    'Origin' => 'https://onestop.ucas.ac.cn',
    'Sec-Fetch-Site' => 'same-origin',
    'Sec-Fetch-Mode' => 'cors',
    'Sec-Fetch-Dest' => 'empty',
    'Referer' => 'https://onestop.ucas.ac.cn/',
    'Accept-Language' => 'zh-CN,zh;q=0.9'
  }

  ONESTOP_URL_S = 'https://onestop.ucas.ac.cn'
  LOGIN_URL_S = 'https://onestop.ucas.ac.cn/Ajax/Login/0'
  COURSE_INFO_URL_S = 'https://course.ucas.ac.cn/portal'
  LOGIN_COURSE_URL_S = 'https://course.ucas.ac.cn/portal/plogin'

  ONESTOP_URL = 'http://onestop.ucas.ac.cn'
  LOGIN_URL = 'http://onestop.ucas.ac.cn/Ajax/Login/0'
  SEP_URL = 'http://sep.ucas.ac.cn'
  COURSE_INFO_URL = 'http://sep.ucas.ac.cn/portal/site/16/801'
  LOGIN_COURSE_URL = 'http://course.ucas.ac.cn/portal/plogin'
  APPSTORE_URL = 'http://sep.ucas.ac.cn/appStore'
end
