module FlickrCollage
  class Config
    Error = Class.new(StandardError)
    Unconfigured = Class.new(Error)

    def initialize(env = ENV)
      @env = env
    end

    def flickr_api_key
      @flickr_api_key ||= fetch_key('FLICKR_API_KEY')
    end

    def flickr_shared_key
      @flickr_shared_key ||= fetch_key('FLICKR_SHARED_SECRET')
    end
    private

    def fetch_key(key)
      @env.fetch(key) { raise Unconfigured, "Please set env value of #{ key }"}
    end
  end
end
