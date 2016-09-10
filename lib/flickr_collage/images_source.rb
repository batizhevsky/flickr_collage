module FlickrCollage
  class ImagesSource
    def initialize(source_api: FlickrCollage::FlickrHandler.new)
      @source_api = source_api
    end

    def url_by_tag(tag)
      response = @source_api.top_with_tag(tag)
      response['url'] if response
    end
  end
end
