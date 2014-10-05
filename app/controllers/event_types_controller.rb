class EventTypesController < InheritedResources::Base
	def create
	  @event_type = EventType.create( params[:event_type] )
	  respond_to do |format|
      if @event_type.save
        format.html { redirect_to @event_type, notice: 'Event Type was successfully created.' }
        format.json { render json: @event_type, status: :created, location: @event_type }
        
      else
        format.html { render action: "new" }
        format.json { render json: @event_type.errors, status: :unprocessable_entity }
      end
    end
	end
end
