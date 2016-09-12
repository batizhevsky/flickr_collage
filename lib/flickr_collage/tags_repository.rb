module FlickrCollage
  class TagsRepository
    include Enumerable
    def initialize(source_file: ::File.open('/usr/share/dict/words'))
      @file = source_file
      @positions = @file.each_line.inject([0]) { |memo,l| memo << memo.last + l.size }.shuffle
    end

    def tag
      @file.seek(@positions.pop)
      @file.gets.chomp.downcase
    end

    # @param size [Fixnum] number of generated tags
    def generate_tags(size)
      size.times.map { tag }
    end
  end
end
