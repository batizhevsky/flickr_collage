require 'spec_helper'

RSpec.describe FlickrCollage::CreateCollage do
  let(:landscape) { Magick::Image.from_blob(IO.read(File.expand_path('../../fixtures/landscape.png', __FILE__))).first }

  describe '#call' do
    it 'create a collage from photos' do
      result_image = subject.call(10.times.map { landscape })

      expect(result_image).to be_kind_of(Magick::Image)
    end
  end
end
