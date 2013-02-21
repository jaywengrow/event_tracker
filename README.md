# EventTracker

EventTracker is a super-lightweight event tracking framework for Ruby on Rails. You can easily track anything and everything in any part of your codebase and view the data on a built-in dashboard.

## Requirements

This has only been tested on Ruby on Rails version 3.

EventTracker uses redis as a datastore.

EventTracker only supports redis 2.0 or greater.

If you're on OS X, Homebrew is the simplest way to install Redis:

    $ brew install redis
    $ redis-server /usr/local/etc/redis.conf

You now have a Redis daemon running on 6379.

## Installation

Add this line to your application's Gemfile:

    gem 'event_tracker', :git => "git://github.com/jaywengrow/event_tracker.git"

And then execute:

    $ bundle

## Configuration

EventTracker is autoloaded when rails starts up, as long as you've configured redis it will 'just work'.

You may want to change the Redis host and port EventTracker connects to, or set various other options at startup.

EventTracker has a `redis` setter which can be given a string or a Redis
object. This means if you're already using Redis in your app, EventTracker
can re-use the existing connection.

For our rails app we have a `config/initializers/event_tracker.rb` file where
we load `config/event_tracker.yml` by hand and set the Redis information
appropriately.

Here's our `config/event_tracker.yml`:

``` yaml
development: localhost:6379
test: localhost:6379:1
staging: redis1.se.github.com:6379
production: redis1.ae.github.com:6379
```

Note that separated Redis database should be used for test environment
So that you can flush it and without impacting development environment

And our initializer:

``` ruby
rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
rails_env = Rails.env || 'development'

event_tracker_config = YAML.load_file(rails_root.to_s + '/config/event_tracker.yml')
EventTracker.redis = event_tracker_config[rails_env]
```

## Usage

You can track an event at any point in your codebase, such as a controller or model using the `track_event`	method, containing any symbol as a parameter:

``` ruby
track_event(:user_signed_up)
```

This will assign 1 point to the event 'user_signed_up'. Any time the event gets "tracked" in the future, its count will increment by 1.

You can optionally assign a number of points to a particular event by adding a number as a second parameter:

``` ruby
track_event(:user_earned_store_credit, 5)
```

This will assign 5 points to the 'user_earned_store_credit' event, and in this example, the number of points would represent the total of how many dollars of credit have ever been earned.

## Web Interface

EventTracker comes with a Sinatra-based front end to get an overview of how your experiments are doing.

You can mount this inside your app routes by first adding this to the Gemfile:

    gem 'event_tracker', :git => "git://github.com/jaywengrow/event_tracker.git", :require => 'event_tracker/dashboard'

Then adding this to config/routes.rb

    mount EventTracker::Dashboard, :at => 'event_tracker'

You may want to password protect that page, you can do so with `Rack::Auth::Basic`

    EventTracker::Dashboard.use Rack::Auth::Basic do |username, password|
      username == 'admin' && password == 'p4s5w0rd'
    end

## Development

Source hosted at [GitHub](http://github.com/jaywengrow/event_tracker).
Report Issues/Feature requests on [GitHub Issues](http://github.com/jaywengrow/event_tracker/issues).

Tests can be ran with `rake spec`

### Note on Patches/Pull Requests

 * Fork the project.
 * Make your feature addition or bug fix.
 * Add tests for it. This is important so I don't break it in a
   future version unintentionally.
 * Commit, do not mess with rakefile, version, or history.
   (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
 * Send me a pull request. Bonus points for topic branches.
