require 'test_helper'

class FileRecordTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: "user0", remember_token: "xyz")
    root_path = "./app/assets/resources/"
    @path = "177223/数理逻辑课件/作业/lianxi1.pdf"
    @name = "lianxi1.pdf"
    @address = "https://course.ucas.ac.cn/access/content/group/177223/%E6%95%B0%E7%90%86%E9%80%BB%E8%BE%91%E8%AF%BE%E4%BB%B6/%E4%BD%9C%E4%B8%9A/lianxi1.pdf"
    @f1 = FileRecord.create(path: @path, has_children: false, unread: true, user: @user, course: false, name: @name)
  end

  # test "child function works" do
  #   path0 = "100/"
  #   path1 = "100/101"
  #   path2 = "100/102/"
  #   path3 = "100/103/104"
  #   assert(FileRecord.child?(path1, path0))
  #   assert(FileRecord.child?(path2, path0))
  #   assert_not(FileRecord.child?(path3, path0))
  # end

  # test "record_to_hash function workds" do
  #   path0 = "/100/"
  #   path1 = "/100/101"
  #   path2 = "/100/102/"
  #   path3 = "/100/103/104"
  #   user = User.create(email: "user1", remember_token: "xyz")
  #   FileRecord.create(user: user, has_children: true, unread: false, path: path0, course: false, name: "100")
  #   FileRecord.create(user: user, has_children: false, unread: false, path: path1, course: false, name: "101")
  #   FileRecord.create(user: user, has_children: true, unread: false, path: path2, course: false, name: "102")
  #   FileRecord.create(user: user, has_children: false, unread: false, path: path3, course: false, name: "104")
  #   all = FileRecord.where(user: user)
  #   puts FileRecord.record_to_hash(all.first, all)
  # end
end
