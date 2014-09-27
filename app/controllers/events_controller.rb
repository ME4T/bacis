require 'yaml'
class EventsController < ApplicationController
    def mercury_update
      post = Event.find(params[:id])
      # Update page
      post.title=params[:content][:page_topic][:value]
      post.desc= params[:content][:page_body][:value] 
      post.address=params[:content][:page_address][:value] 
      post.save!
      render :json => {:url => post_path(post)}
    end
    
    def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
    def index
    @locations = Event.all
    @json = Event.all.to_gmaps4rails
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end 
  end
  def new
      @event = Event.new 
      @event_activities = EventActivity.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @event }
      end 
 
  end
 
  def create 
    @event = Event.new(params[:event])
    @event.desc.sub! "\n", "<br />"
    if @event.website.to_s.include? "http"
      #do nothing
    else
      @event.website = "http://" + @event.website.to_s
    end
    @event_activities = EventActivity.all
    @event.user_id = current_user.id

    respond_to do |format|
      if @event.save
        Notifier.send_new_event_notification(@event)

        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
        
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update 
    @event = Event.find(params[:id])
    @event_activities = EventActivity.all
    @event.desc.sub! "\n", "<br />"
    if @event.website.to_s.include? "http"
      #do nothing
    else
      @event.website = "http://" + @event.website.to_s
    end
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end
  def edit 
    @event=Event.find(params[:id])
    @event_activities = EventActivity.all
  end


  def show
    @event=Event.find(params[:id])
    if(@event.event_activities)
      @event_activities = EventActivity.find(@event.event_activities)
    end
    @site= "<a href='https://"+@event.website.to_s+"'> </a>"
  end




  def index
    @events=Event.all
    
  end
  def list
    @event=Event.all
  end
  def map
    @event=Event.all
  end
  def myevent
    @events=Event.all
    
  end
end
