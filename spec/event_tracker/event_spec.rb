require 'spec_helper'
require 'event_tracker/event'

describe EventTracker::Event do
  before(:each) { EventTracker.redis.flushall }
  
	it "should have a name" do
    event = EventTracker::Event.new(:signup)
    event.name.should eql(:signup)
  end

  it "should start with a default score of 0 if not specified" do
    event = EventTracker::Event.new(:signup)
    event.score.should eq(0)
  end

  describe 'save' do

    it "should save to redis" do
      event = EventTracker::Event.new(:signup)
      event.save
      EventTracker.redis.exists(:events).should be true
    end

    it "should save score to redis associated with event" do
      event = EventTracker::Event.new(:signup, 10)
      event.save
      EventTracker::Event.find(:signup).score.should eq(10)
    end

  end

  describe 'find' do
    it "should return an existing event" do
      event = EventTracker::Event.new(:signup)
      event.save
      EventTracker::Event.find(:signup).name.should eq(:signup)
    end

    it "should not return a non-existing event" do
      EventTracker::Event.find(:no_such_event).should be_nil
    end
  end

  describe 'all' do
    it "should return all events" do
      event = EventTracker::Event.new(:signup)
      event.save
      second_event = EventTracker::Event.new(:purchase)
      second_event.save
      all_events = EventTracker::Event.all
      all_events.first.name.should eq(:purchase) #purchase comes first alphabetically
      all_events.last.name.should eq(:signup)
    end

  end

  describe 'delete' do

    it "should delete an existing event" do
      event = EventTracker::Event.new(:signup)
      event.save
      
      event.delete
      EventTracker::Event.find(:signup).should be_nil
    end

  end

  describe 'increase_points' do

    it "should increase event's points by specified number" do
      event = EventTracker::Event.new(:signup)
      event.increase_score(3)
      event.save
      EventTracker::Event.find(:signup).score.should eq(3)
    end
  end

end