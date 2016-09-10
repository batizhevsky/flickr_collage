require 'spec_helper'

RSpec.describe FlickrCollage::FlickrHandler do
  let(:api_client) { double('flickr_api') }

  subject { described_class.new(api_client: api_client) }

  describe '#top_with_tag' do
    it 'calls an api client' do
      expect(api_client).to receive_message_chain(:photos, :search).with({
          tags: ['test_tag'],
          extras: 'url_c',
          sort: 'interestingness-desc',
          per_page: 1
        }) { [] }

      subject.top_with_tag('test_tag')
    end

    it 'returns a hash with image url' do
      allow(api_client).to receive_message_chain(:photos, :search) do
        [{
          'id' => '21872151562',
          'url_c' => 'https://farm6.staticflickr.com/5798/21872151562_318b196b23_c.jpg',
          'height_c' => 534, 'width_c' => '800'
        }]
      end

      result = subject.top_with_tag('test_tag')
      expect(result['url']).to eq 'https://farm6.staticflickr.com/5798/21872151562_318b196b23_c.jpg'
    end

    it 'returns an empty hash if no results' do
      allow(api_client).to receive_message_chain(:photos, :search) { [] }

      result = subject.top_with_tag('non_exists')
      expect(result).to eq nil
    end
  end
end
