require 'rmagick'

module FlickrCollage
  class ProcessImage
    def crop_rectangular(img_blob)
      img = Magick::Image.from_blob(img_blob).first

      columns = img.columns
      rows = img.rows
      cropped_columns = img.columns * 0.75

      if  cropped_columns > rows
        columns = rows * 1.3
      else
        rows = cropped_columns
      end

      img.crop(Magick::CenterGravity, columns.floor, rows.floor)
    end
  end
end
