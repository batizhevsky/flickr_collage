require 'flickraw'
require 'http'

module FlickrCollage
  class FlickrHandler
    def initialize(config: FlickrCollage.config)
      @base_url = 'https://api.flickr.com'
      @path = '/services/rest/'

      @connection = HTTP.persistent(@base_url)

      @default_params = {
        api_key: config.flickr_api_key,
        shared_secret: config.flickr_shared_key,
        format: :json,
        nojsoncallback: 1
      }
    end

    def top_with_tag(tag)
      params = {
        method: 'flickr.photos.search',
        tags: [tag],
        extras: 'url_c',
        sort: 'interestingness-desc',
        per_page: 5
      }

      images = request_with_params(params)
      image = images.select { |image| image['url_c'] }.first

      if image
        image['url'] = image['url_c']
        image
      end
    end

    private

    def request_with_params(params)
      response = @connection.get(@path, params: params.merge(@default_params)).to_s
      json = JSON.load(response)
      if json && json['photos'] && json['photos']['photo']
        json['photos']['photo']
      else
        []
      end
    end
  end
end
