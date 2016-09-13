require 'spec_helper'

RSpec.describe FlickrCollage::Client  do
  let(:image_fetcher) { instance_double(FlickrCollage::FetchImages) }
  let(:collage_creator) { instance_double(FlickrCollage::CreateCollage) }
  let(:image_processor) { instance_double(FlickrCollage::ProcessImage) }
  let(:image_source) { instance_double(FlickrCollage::ImagesSource) }

  subject do
    described_class.new(
      image_fetcher: image_fetcher,
      collage_creator: collage_creator,
      image_processor: image_processor,
      image_source: image_source
    )
  end

  describe '#call' do
    it 'makes all works together' do
      image_urls = 10.times.map { double('url') }
      images = 10.times.map { double('image') }
      cropped_image = double('cropped_image')

      options = OpenStruct.new(tags: %w(olympus nikon bronica canon pentax), output_file: '/tmp/output.png')

      expect(image_source).to receive(:images_urls).with(%w(olympus nikon bronica canon pentax)) { image_urls }
      expect(image_fetcher).to receive(:call).with(image_urls) { images }
      expect(image_processor).to receive(:crop_rectangular).exactly(10).times { cropped_image }
      expect(collage_creator).to receive(:call).with(10.times.map { cropped_image }, '/tmp/output.png')

      filename = subject.call(options)
      expect(filename).to eq '/tmp/output.png'
    end
  end

end
