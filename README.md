# Flickr Collage

Creates a collage from Flickr top ranked images picked by tags

## Installation

You should have ImageMagic installed in your system, more info: http://rmagick.rubyforge.org/install-faq.html

Clone this repository to your computer

    $ git clone https://github.com/batizhevsky/flickr_collage

Enter to dir
    
    $ cd flickr_collage

Install dependencies:

    $ bundle

## Usage

Flickr API keys required. You could get them from https://www.flickr.com/services/apps/create/
You could export them as env variables `export FLICKR_API_KEY=key` and `export FLICKR_SHARED_SECRET=secret`
or you could specify them at `.env` file (see https://github.com/bkeepers/dotenv)

To start run

    $ bin/flickr_collage
  
and your see help output

The simples run:

    $ bin/flickr_collage /tmp/random_tags_collage.jpeg
    
or with dotenv (to load API keys from file):

    $ dotenv bin/flickr_collage /tmp/random_tags_collage.jpeg


You could specify tags:

    $ ./bin/flickr_collage --tags olympus nikon bronica canon pentax /tmp/colage_output.png


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/flickr_collage.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

