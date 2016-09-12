require 'http'
module FlickrCollage
  class FetchImages
    def initialize
    end

    def call(urls)
      urls = Array(urls)

      threads = urls.map do |url|
        Thread.new do
          HTTP.timeout(:per_operation, write: 2, connect: 5, read: 10)
          .get(url).body.to_s
        end
      end

      threads.map do |thread|
        thread.value
      end
    end
  end
end
