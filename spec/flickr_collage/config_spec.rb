require 'spec_helper'

RSpec.describe FlickrCollage::Config do
  let(:env) { Hash.new }

  subject { described_class.new(env) }

  describe '#flickr_api_key' do
    it 'raise error if not set' do
      expect { subject.flickr_api_key }.to raise_error(FlickrCollage::Config::Unconfigured)
    end

    it 'returns env value' do
      env['FLICKR_API_KEY'] = 'something'
      expect(subject.flickr_api_key).to eq 'something'
    end
  end

  describe '#flickr_shared_key' do
    it 'raise error if not set' do
      expect { subject.flickr_shared_key }.to raise_error(FlickrCollage::Config::Unconfigured)
    end

    it 'returns env value' do
      env['FLICKR_SHARED_SECRET'] = 'other'
      expect(subject.flickr_shared_key).to eq 'other'
    end
  end
end
