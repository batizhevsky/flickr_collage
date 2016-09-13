require 'rmagick'
require 'tempfile'

module FlickrCollage
  class CreateCollage
    def call(images, output='/tmp/collage.png')
      result_image = Magick::ImageList.new
      result_image.push(*images)

      largest_image = images.sort_by { |image| image.rows }.last
      result_image.montage {
        self.tile = '5x2'
        self.background_color = 'black'
        self.geometry = "#{ largest_image.columns }x#{ largest_image.rows }+10+10"
        self.border_width = 10
        self.border_color = 'black'
      }
      .trim(true)
      .border(10, 10, 'black')
      .write(output)
    end
  end
end
