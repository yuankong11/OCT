class FileRecord < ApplicationRecord
  belongs_to :user
  COURSE_URL_S = "https://course.ucas.ac.cn/access/content/group/"
  ROOT_PATH = "./app/assets/resources/"

  def full_path
    FileRecord.path_to_full_path(path)
  end

  def address
    FileRecord.path_to_address(path)
  end

  def read
    update_attributes(unread: false)
  end

  def self.address_to_path(address)
    URI.decode(address).gsub(COURSE_URL_S, "")
  end

  def self.path_to_name(path)
    path.scan(/\/([^\/]*?)\/?$/)[0][0]
  end

  def self.path_to_full_path(path)
    ROOT_PATH + path
  end

  def self.path_to_address(path)
    URI.encode(COURSE_URL_S + path)
  end

  def self.record_to_hash(f, records)
    info = {
      "name" => f.name,
      "address" => f.address
    }
    if f.has_children
      info["children"] = records.select do |r|
        FileRecord.child?(r.path, f.path)
      end.map do |r|
        FileRecord.record_to_hash(r, records)
      end
      info["file"] = "folder"
    elsif postfixs = f.name.scan(/\.(\w+)$/)[0]
      info["file"] = postfixs[0]
    else
      info["file"] = "unknown"
    end
    info
  end

  def self.child?(cpath, ppath)
    puts cpath
    puts ppath
    if cpath.index(ppath) == 0
      return (cpath.gsub(ppath, "") =~ /[^\/]+\/?$/) == 0
    else
      false
    end
  end
end
