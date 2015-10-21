class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	# Begfore anything is executed, run the function pass_in_events_for_footer
	before_filter :pass_in_events_for_footer
	def pass_in_events_for_footer
		# If user is signed in
		@nc_events = Event.all.past.notcompleted.notstatic
		if current_user
			# Check if the user has a schedule, and if so, pull out those events
		    @schedule = Schedule.all.where(user_id: current_user.id).first
	      	@events = nil
	    	if !@schedule.nil?
	        	# All Events in the User's Schedule 
	        	@events = Event.all.where(schedule_id: @schedule.id)
			end
		end
	end

end
