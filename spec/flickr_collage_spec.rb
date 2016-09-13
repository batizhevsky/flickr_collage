require 'spec_helper'
require 'fileutils'

RSpec.describe FlickrCollage do
  it 'has a version number' do
    expect(FlickrCollage::VERSION).not_to be nil
  end

  it 'create a collage' do
    unless ENV['REAL_REQUEST']
      skip 'Skipping the real requests test. To run in pass REAL_REQUEST=true'
    end

    FileUtils.rm_rf '/tmp/colage_output.png'
    status = system('dotenv ./bin/flickr_collage --tags olympus nikon bronica canon pentax /tmp/colage_output.png')
    expect(status).to be_truthy

    expect(File).to be_exist('/tmp/collage_output.png')
  end
end
