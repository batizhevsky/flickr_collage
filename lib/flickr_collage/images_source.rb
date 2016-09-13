module FlickrCollage
  class ImagesSource
    extend Forwardable
    def_delegator :FlickrCollage, :logger

    def initialize(
      repository: TagsRepository.new,
      source_api: FlickrHandler.new
      )
      @source_api = source_api
      @repository = repository
    end

    def url_by_tag(tag)
      response = @source_api.top_with_tag(tag)
      response['url'] if response
    end

    def images_urls(tags, max_count = IMAGES_COUNT)
      return tags if max_count == 0

      lacking_tags = max_count - tags.size

      if lacking_tags > 0
        generated_tags = @repository.generate_tags(lacking_tags)
        tags.concat(generated_tags)
      end

      logger.info "Get images by tags: #{ tags }"

      image_urls = tags.map do |tag|
        result = url_by_tag(tag)
        logger.debug "Couldn't find any image by the tag: #{ tag }" unless result
        result
      end.compact

      lacking_images = max_count - image_urls.size
      image_urls.concat(images_urls([], lacking_images))
    end
  end
end
