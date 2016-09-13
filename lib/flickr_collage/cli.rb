require 'optparse'

module FlickrCollage
  class CLI
    class ParsingResult
      attr_accessor :tags, :output_file, :output

      def initialize
        self.tags = []
      end
    end

    attr_reader :result

    def initialize(result: ParsingResult.new)
      @result = result
    end

    def call(args)
      option_parser.parse!(args)
      filename = args.pop

      if filename
        result.output_file = filename
      else
        @result.output = option_parser.help
      end

      @result
    end

    def option_parser
      OptionParser.new do |opts|
        opts.banner = <<-TEXT
FlickrCollage creates a collage from Flickr images. Just pass tags (upto ten) or enjoy a random pic'
Usage: bin/flickr_collage --tags tag_one,tag_two,tag_three outputfile.jpg
        TEXT

        opts.on('--tags tag_one,tag_two', Array, 'Specify exact tags. Max 10. More will be dropped') do |tags|
          result.tags = tags.map(&:downcase).uniq[0..9]
        end
      end
    end
  end
end
