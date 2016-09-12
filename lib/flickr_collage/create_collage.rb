require 'rmagick'
require 'tempfile'

module FlickrCollage
  class CreateCollage
    def call(images, output='/tmp/collage.png')
      result_image = Magick::ImageList.new
      result_image.push(*images)

      result_image.montage {
        self.tile = '5x2'
        self.background_color = 'black'
        self.geometry = "#{ images.first.columns }x#{ images.first.rows }+10+10"
        self.border_width = 10
        self.border_color = 'black'
      }
      .trim(true)
      .border(10, 10, 'black')
      .write(output)
    end
  end
end
