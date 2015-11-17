# Logr

Structured logging with metrics and events.

![Travis](https://api.travis-ci.org/sspinc/avro2kafka.svg?branch=master)

## Description

“Chaos was the law of nature; Order was the dream of man.”
― Henry Adams

Logr is a machine-friendly logging library for Ruby. It brings structure
to what is usually just a messy stream of human-readable output, so you
can later slice and dice your logs with ease. The library was designed with
monitoring and analytics platforms in mind: bringing together events and
metrics from your services and applications has never been easier.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'logr'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install logr

## Usage

```ruby
require 'logr'

class YourClass
  def self.logger
    @logger ||= Logr::Logger.new('your-logger-name')
  end

  .
  .
  .

  # A complex event that you want to monitor and has metrics associated
  YourClass.logger.event('event-name', arbitrary: 'context', add_what: 'you_need')
                  .monitored('Title of the event', 'A longer description.')
                  .metric('metric-name', 34.35)
                  .metric('loglines', 1234535, type: 'counter')
                  .info('Human readable old-school logline')

  # A simple logline
  YourClass.logger.warn('Oh-oh something is fishy!')
end
```

The first log line pretty printed:
```json
{
  "timestamp":"2015-11-16 16:47:42 UTC",
  "level":"INFO",
  "logger":"your-logger-name",
  "event":{
    "name":"event-name",
    "arbitrary":"context",
    "add_what":"you_need",
    "monitored":true,
    "title":"Title of the event",
    "text":"A longer description."},
  "metrics":[
    {
      "name":"metric-name",
      "value":"add as many as you like",
      "type":"counter"
    },
    {
      "name":"loglines",
      "value":1234535,
      "type":"counter"
    }],
  "message":"Human readable old-school logline"
}
```

Log line with simple message:
```json
{
  "timestamp":"2015-11-16 16:47:42 UTC",
  "level":"WARN",
  "logger":"your-logger-name",
  "message":"Oh-oh somethign is fishy!"
}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sspinc/logr.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

