require 'spec_helper'
require 'flickr_collage'

RSpec.describe FlickrCollage::CLI  do
  context 'arguments not passed' do
    it 'prints help message' do
      result = subject.call([])
      expect(result.output).to eq <<-TEXT
FlickrCollage creates a collage from Flickr images. Just pass tags (upto ten) or enjoy a random pic'
Usage: bin/flickr_collage --tags tag_one,tag_two,tag_three outputfile.jpg
        --tags tag_one,tag_two       Specify exact tags. Max 10. More will be dropped
      TEXT
    end

    it 'returns nothing' do
      result = subject.call([])
      expect(result.tags).to be_empty
      expect(result.output_file).to be_nil
    end
  end

  context 'full arguments passed' do
    it 'returns options' do
      args = %w(--tags tag_one,tag_two,tag_three outputfile.jpg)
      result = subject.call(args)

      expect(result.tags).to eq(['tag_one', 'tag_two', 'tag_three'])
      expect(result.output_file).to eq('outputfile.jpg')
      expect(result.output).to be_nil
    end
  end
end
