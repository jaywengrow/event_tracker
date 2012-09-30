require 'spec_helper'
require 'event_tracker/helper'

describe EventTracker::Helper do
  include EventTracker::Helper

  before(:each) do
  	EventTracker.redis.flushall
  end

  describe "track_event" do

    it "should create and save new event if it does not yet exist" do
      track_event(:signup)
      event = EventTracker::Event.find(:signup)
      event.should_not be_nil
    end

    it "should add points to an existing event" do
      track_event(:signup)
      track_event(:signup)
      event = EventTracker::Event.find(:signup)
      event.score.should eq(2)
    end

  	it "should by default add one point to an event" do
  		event = EventTracker::Event.new(:signup)
  		event.save
  		track_event(:signup)
  		event = EventTracker::Event.find(:signup)
  		event.score.should eq(1)
  	end

    it "should add specified number of points to an event" do
      event = EventTracker::Event.new(:signup)
      event.save
      track_event(:signup, 7)
      event = EventTracker::Event.find(:signup)
      event.score.should eq(7)
    end

  end

end