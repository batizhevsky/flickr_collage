require 'spec_helper'
require "http"

RSpec.describe FlickrCollage::FetchImages do
  describe '#download' do
    context 'single url passed' do
      it 'returns downloaded data' do
        url = 'http://example.com/path'

        stub_request(:get, 'http://example.com/path').to_return(status: 200, body: 'text')

        expect(subject.call(url)).to eq(['text'])
      end
    end

    context 'multiple urls passed' do
      it 'returns downloaded data' do
        url1 = 'http://example.com/path1'
        url2 = 'http://example.org/path2'

        stub_request(:get, 'http://example.com/path1').to_return(status: 200, body: 'text1')
        stub_request(:get, 'http://example.org/path2').to_return(status: 200, body: 'text2')

        expect(subject.call([url1, url2])).to eq(['text1', 'text2'])
      end
    end
  end
end
