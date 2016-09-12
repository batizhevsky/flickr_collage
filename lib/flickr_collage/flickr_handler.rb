require 'flickraw'

module FlickrCollage
  class FlickrHandler
    def initialize(api_client: flickr_api)
      @api = api_client
    end

    def top_with_tag(tag)
      result = @api.photos.search({
        tags: [tag],
        extras: 'url_c',
        sort: 'interestingness-desc',
        per_page: 1
      }).first

      if result
        result = result.to_hash
        result['url'] = result['url_c']
        result
      end
    end

    private

    def flickr_api
      FlickRaw::Flickr.new(api_key: ENV['FLICKR_API_KEY'], shared_secret: ENV['FLICKR_SHARED_SECRET'])
    end
  end
end
