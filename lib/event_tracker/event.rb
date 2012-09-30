module EventTracker
  class Event

  	attr_accessor :name
    attr_accessor :score

  	def initialize(name, score=0)
  		@name = name
      @score = score
  	end

    def self.find(event_name)
      score = EventTracker.redis.zscore(:events, event_name)
      if score
        event = Event.new(event_name, score)
      else
        nil
      end
    end

    def self.all
      Array(EventTracker.redis.zrange(:events, 0, -1)).map {|e| find(e.to_sym)}
    end

  	def save
  		EventTracker.redis.zadd(:events, @score, @name)
  	end

    def delete
      EventTracker.redis.zrem(:events, @name)
    end

    def increase_score(points)
      @score += points
    end





  end
end