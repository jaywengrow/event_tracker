module EventTracker
  class Event

  	attr_accessor :name

  	def initialize(name)
  		@name = name
  	end

  	def save
  		EventTracker.redis.zadd(:events, @name, 1)
  	end

  end
end