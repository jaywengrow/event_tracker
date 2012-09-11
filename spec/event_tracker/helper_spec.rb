require 'spec_helper'
require 'event_tracker/helper'

describe EventTracker::Helper do
  include EventTracker::Helper

  before(:each) do
  	EventTracker.redis.flushall
  end

  describe "track_event" do

  	it "should by default add one point to an event" do
  		event = EventTracker::Event.new(:signup)
  		event.save
  		track_event(:signup)
  		event = EventTracker::Event.find(:signup)
  		event.score.should eq(1)
  	end

  end

end