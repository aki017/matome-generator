
require "json"
require "erb"
entries = []
Dir.glob("ss/data/**/*.json").each do |f|
  next if Time.now - File.stat(f).mtime > 30*24*60*60 # 30 days
  data = JSON.parse(File.read(f))
  data["time"] = Time.parse(data["time"]).localtime
  entries << data
end

FileUtils.mkdir_p "ss/html"
File.write "ss/html/index.html", ERB.new(File.read("ss/erb/index.html.erb")).result
