module Eventy
  class Event

  	attr_accessor :name
    attr_accessor :score

  	def initialize(name, score=0)
  		@name = name
      @score = score
  	end

    def self.find(event_name)
      score = Eventy.redis.zscore(:events, event_name)
      if score
        event = Event.new(event_name, score.to_i)
      else
        nil
      end
    end

    def self.find_or_create(event_name)
      score = Eventy.redis.zscore(:events, event_name)
      if score
        event = Event.new(event_name, score.to_i)
      else
        event = Event.new(event_name)
      end
    end

    def self.all
      Array(Eventy.redis.zrange(:events, 0, -1)).map {|e| find(e.to_sym)}
    end

  	def save
  		Eventy.redis.zadd(:events, @score, @name)
  	end

    def delete
      Eventy.redis.zrem(:events, @name)
    end

    def increase_score(points)
      @score += points
    end





  end
end