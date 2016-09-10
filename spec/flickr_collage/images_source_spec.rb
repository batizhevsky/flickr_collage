require 'spec_helper'

RSpec.describe FlickrCollage::ImagesSource do
  let(:api) { instance_double(FlickrCollage::FlickrHandler) }

  subject { described_class.new(source_api: api) }

  describe '#with_tag' do
    context 'an image with the tag exist' do
      it 'returns a image' do
        expect(api).to receive(:top_with_tag).with('test_tag') do
          { 'url' => 'https://farm6.staticflickr.com/5798/21872151562_318b196b23_c.jpg' }
        end

        image = subject.url_by_tag('test_tag')
        expect(image).to be_instance_of(String)
        expect(image).to match(URI::regexp)
      end
    end
  end

  context 'an image with the tag dont exist' do
    it 'returns a nil' do
      expect(api).to receive(:top_with_tag).with('test_tag')

      image = subject.url_by_tag('test_tag')
      expect(image).to be_nil
    end
  end
end
