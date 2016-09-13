require 'spec_helper'

RSpec.describe FlickrCollage::ProcessImage do
  let(:square_image) { IO.read(File.expand_path('../../fixtures/square.png', __FILE__)) }
  let(:landscape) { IO.read(File.expand_path('../../fixtures/landscape.png', __FILE__)) }
  let(:portrait) { IO.read(File.expand_path('../../fixtures/portrait.png', __FILE__)) }


  def landscape_rectangle?(image)
    image.columns > image.rows
  end

  def true_photo_ratio?(image)
    (image.columns.to_f / image.rows).to_s[0..2] == '1.3'
  end

  describe '#crop_rectangular' do
    [:square_image, :landscape, :portrait].each do |img|
      it "crops a #{ img } rectangular" do
        result_image = subject.crop_rectangular(send(img))

        expect(result_image).to be_kind_of(Magick::Image)
        expect(landscape_rectangle? result_image).to eq true
        expect(true_photo_ratio? result_image).to eq true
      end
    end
  end
end
