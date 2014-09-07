class EventActivitiesController < InheritedResources::Base
	def create
	  @event_activity = EventActivity.create( params[:event_activity] )
	  respond_to do |format|
      if @event_activity.save
        format.html { redirect_to @event_activity, notice: 'Event Activity was successfully created.' }
        format.json { render json: @event_activity, status: :created, location: @event_activity }
        
      else
        format.html { render action: "new" }
        format.json { render json: @event_activity.errors, status: :unprocessable_entity }
      end
    end
	end
end
