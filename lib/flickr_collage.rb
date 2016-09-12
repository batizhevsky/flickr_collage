require 'logger'
require 'flickr_collage/version'
require 'flickr_collage/cli'
require 'flickr_collage/tags_repository'
require 'flickr_collage/flickr_handler'
require 'flickr_collage/images_source'
require 'flickr_collage/fetch_images'
require 'flickr_collage/process_image'
require 'flickr_collage/create_collage'

module FlickrCollage
  IMAGES_COUNT = 10

  class << self
    attr_accessor :logger
  end

  self.logger ||= Logger.new(STDOUT)

  def self.new(options)
    urls = images_urls(options.tags)
    images = FetchImages.new.call(urls)
    logger.info 'Images fetched. Cropping...'

    binding.pry
    cropped_images = images.map { |image| ProcessImage.new.crop_rectangular(image) }
    logger.info 'Creating a collage...'
    CreateCollage.new.call(cropped_images, options.output_file)
    logger.info "The collage saved to options.output_file"
  end

  # @param tags [Array]
  def self.images_urls(tags, max_count = IMAGES_COUNT)
    return tags if max_count == 0

    lacking_tags =  max_count - tags.size
    if lacking_tags > 0
      generated_tags = TagsRepository.new.generate_tags(lacking_tags)
      tags.concat(generated_tags)
    end

    logger.info "Get images by tags: #{ tags }"

    image_urls = tags.map do |tag|
      result = ImagesSource.new.url_by_tag(tag)
      logger.debug "Couldn't find image by the tag: #{ tag }" unless result
      result
    end.compact

    lacking_images = max_count - image_urls.size
    image_urls.concat(images_urls([], lacking_images))
  end
end

options = OpenStruct.new(tags: %w(olympus nikon bronica canon pentax), output_file: '/tmp/output.png')
FlickrCollage.new(options)
