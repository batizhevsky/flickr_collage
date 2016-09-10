module FlickrCollage
  class TagsRepository
    include Enumerable
    def initialize(source: '/usr/share/dict/words')
      @file = ::File.open(source)
      @positions = @file.each_line.inject([0]) { |memo,l| memo << memo.last + l.size }.shuffle
    end

    def tag
      @file.seek(@positions.pop)
      @file.gets
    end
  end
end
