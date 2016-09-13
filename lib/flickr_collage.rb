require 'logger'
require 'forwardable'
require 'flickr_collage/version'
require 'flickr_collage/config'
require 'flickr_collage/cli'
require 'flickr_collage/tags_repository'
require 'flickr_collage/flickr_handler'
require 'flickr_collage/images_source'
require 'flickr_collage/fetch_images'
require 'flickr_collage/process_image'
require 'flickr_collage/create_collage'
require 'flickr_collage/client'

module FlickrCollage
  IMAGES_COUNT = 10

  class << self
    attr_accessor :logger
    attr_accessor :config
  end

  self.logger ||= Logger.new(STDOUT)
  self.config ||= Config.new
end

# options = OpenStruct.new(tags: %w(olympus nikon bronica canon pentax), output_file: '/tmp/output.png')
# FlickrCollage.new(options)
