require 'spec_helper'
require 'event_tracker/event'

describe EventTracker::Event do

	it "should have a name" do
    event = EventTracker::Event.new("signup")
    event.name.should eql('signup')
  end

end