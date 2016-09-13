require 'spec_helper'

RSpec.describe FlickrCollage::FlickrHandler do
  let(:config) { { 'FLICKR_API_KEY' => 'api_key', 'FLICKR_SHARED_SECRET' => 'secret' }}

  subject { described_class.new(config: FlickrCollage::Config.new(config) ) }

  describe '#top_with_tag' do
    it 'calls an api client' do
      response = '{ "photos": { "photo": [] }}'
      stub_request(:get, /api\.flickr\.com/).to_return(status: 200, body: response, headers: {})

      subject.top_with_tag('test_tag')

      expect(WebMock).to have_requested(:get, 'https://api.flickr.com/services/rest/').
        with(query: hash_including({
          'method' => 'flickr.photos.search',
          'tags' => 'test_tag',
          'api_key' => 'api_key',
          'shared_secret' => 'secret'
        }))
    end

    it 'returns a hash with image url' do
      response = { photos: { photo: [
        {
          'id' => '21872151562',
          'url_c' => 'https://farm6.staticflickr.com/5798/21872151562_318b196b23_c.jpg',
          'height_c' => 534, 'width_c' => '800'
        }
      ] } }.to_json

      stub_request(:get, /api\.flickr\.com/).
        to_return(status: 200, body: response, headers: {})

      result = subject.top_with_tag('test_tag')
      expect(result['url']).to eq 'https://farm6.staticflickr.com/5798/21872151562_318b196b23_c.jpg'
    end

    it 'returns an empty hash if no results' do
      response = '{ "photos": { "photo": [] }}'

      stub_request(:get, /api\.flickr\.com/).
        to_return(status: 200, body: response, headers: {})

      result = subject.top_with_tag('non_exists')
      expect(result).to eq nil
    end
  end
end
