require 'rmagick'

module FlickrCollage
  class ProcessImage
    def crop_rectangular(img_blob)
      img = Magick::Image.from_blob(img_blob).first
      img.crop(Magick::CenterGravity, (img.columns*0.75).floor, img.rows)
    end
  end
end
