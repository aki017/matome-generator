require "bundler"
require "uri"
require "json"
Bundler.require

target_types = %w(ss)

target_types.each do |tt|
  target_urls = File.read(File.join(tt, "sites.txt")).lines.map(&:strip)

  target_urls.each do |url|
    puts "Start URL: #{url}"

    feed = Feedjira::Feed.fetch_and_parse(url)
    feed.entries.each do |entry|
      uri = URI.parse entry.url

      FileUtils.mkdir_p "#{tt}/data/#{uri.host}#{File.dirname(uri.path)}"
      File.write "#{tt}/data/#{uri.host}#{File.dirname(uri.path)}/#{File.basename(uri.path)}.json", JSON.dump({
        title: entry.title,
          url: entry.url,
          time: entry.published,
      })

    end
  end
end

