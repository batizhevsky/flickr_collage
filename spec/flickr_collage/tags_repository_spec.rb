require 'spec_helper'

RSpec.describe FlickrCollage::TagsRepository do
  describe '#tag' do
    it 'returns a tag' do
      expect(subject.tag).to be_kind_of(String)
    end

    it 'returns a random tag' do
      10.times do
        first_tag = subject.tag
        second_tag = subject.tag

        expect(first_tag).to_not eq second_tag
      end
    end
  end

  describe '#generate_tags' do
    it 'returns expected number of tags' do
      tags = subject.generate_tags(10)
      expect(tags.size).to eq 10
    end
  end
end
