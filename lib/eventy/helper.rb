module Eventy
	module Helper

		def track_event(event_name, points=1)
			event = Eventy::Event.find_or_create(event_name)
			event.increase_score(points)
			event.save
		end


	end
end
