module EventTracker
	module Helper

		def track_event(event_name, points=1)
			event = EventTracker::Event.find(event_name)
			event.increase_score(points)
			event.save
		end


	end
end
