module EventTracker
  class Event

  	attr_accessor :name
    attr_accessor :score

  	def initialize(name, score=0)
  		@name = name
      @score = score
  	end

    def self.find(event)
      score = EventTracker.redis.zscore(:events, event)
      if score
        event = Event.new(event, score)
      else
        nil
      end
    end

  	def save
  		EventTracker.redis.zadd(:events, 1, @name)
  	end

    def delete
      EventTracker.redis.zrem(:events, @name)
    end





  end
end