require 'spec_helper'

RSpec.describe FlickrCollage::ImagesSource do
  let(:api) { instance_double(FlickrCollage::FlickrHandler) }
  let(:tag_repository) { instance_double(FlickrCollage::TagsRepository) }

  subject { described_class.new(source_api: api, repository: tag_repository) }

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

    context 'an image with the tag dont exist' do
      it 'returns a nil' do
        expect(api).to receive(:top_with_tag).with('test_tag')

        image = subject.url_by_tag('test_tag')
        expect(image).to be_nil
      end
    end
  end

  describe '#images_urls' do
    it 'adds missing tags' do
      expect(tag_repository).to receive(:generate_tags).with(1) { ['three'] }
      allow(subject).to receive(:url_by_tag).with('one') { 'url1'}
      allow(subject).to receive(:url_by_tag).with('two') { 'url2'}
      allow(subject).to receive(:url_by_tag).with('three') { 'url3'}

      urls = subject.images_urls(['one', 'two'], 3)
      expect(urls).to eq ['url1', 'url2', 'url3']
    end

    context 'if no url by provided tag' do
      it 'generate new tag' do
        expect(tag_repository).to receive(:generate_tags).with(1) { ['four'] }
        allow(subject).to receive(:url_by_tag).with('one') { 'url1'}
        allow(subject).to receive(:url_by_tag).with('two') { 'url2'}
        allow(subject).to receive(:url_by_tag).with('three') { nil }
        allow(subject).to receive(:url_by_tag).with('four') { 'url4' }

        urls = subject.images_urls(['one', 'two', 'three'], 3)
        expect(urls).to eq ['url1', 'url2', 'url4']

      end

    end
  end
end
