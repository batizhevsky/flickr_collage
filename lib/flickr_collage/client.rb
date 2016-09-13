module FlickrCollage
  class Client
    extend Forwardable
    def_delegator :FlickrCollage, :logger

    def initialize(
      image_fetcher: FetchImages.new,
      collage_creator: CreateCollage.new,
      image_processor: ProcessImage.new,
      image_source: ImagesSource.new
    )
      @image_fetcher = image_fetcher
      @collage_creator = collage_creator
      @image_processor = image_processor
      @image_source = image_source
    end

    def call(options)
      logger.info "Start with tags: #{ options.tags }. Output: #{ options.output_file }"

      urls = @image_source.images_urls(options.tags)
      images = @image_fetcher.call(urls)

      logger.info 'Images fetched. Cropping...'

      cropped_images = images.map { |image| @image_processor.crop_rectangular(image) }
      logger.info 'Creating a collage...'
      @collage_creator.call(cropped_images, options.output_file)
      logger.info "The collage saved to #{ options.output_file }"

      options.output_file
    rescue => e
      puts 'Something goes wrong.'
      puts "Technical info: #{ e }"
    end
  end
end
