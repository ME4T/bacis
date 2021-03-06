require 'yaml'

class EventsController < ApplicationController
  helper_method :sort_column
  helper_method :sort_direction

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

  def new
      @event = Event.new
      @event_activities = EventActivity.all
      @event_types = EventType.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @event }
      end 
 
  end
 
  def create 
    @event = Event.new(params[:event])
    @event_activities = EventActivity.all
    @event_types = EventType.all



    if verify_recaptcha


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
    else
        flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
        flash.delete :recaptcha_error
        render :new
    end
  end

  def update 
    @event = Event.find(params[:id])
    @event_activities = EventActivity.all
    @event_types = EventType.all

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
    @event_types = EventType.all
  end





  def show
    @event=Event.find(params[:id])

    if(@event.twitter_search)    

      begin

        twitter_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = TwitterConfig.config[:consumer_key]
          config.consumer_secret     = TwitterConfig.config[:consumer_secret]
          config.access_token        = TwitterConfig.config[:access_token]
          config.access_token_secret = TwitterConfig.config[:access_token_secret]
        end

        def twitter_client.get_all_tweets(user)
          options = {:count => 3, :include_rts => true}
            user_timeline(user, options)
        end

        @tweet_news = twitter_client.search(@event.twitter_search, result_type: "recent").take(3).collect
      rescue

      end

    end
    if(@event.event_activities)
      @event_activities = EventActivity.find(@event.event_activities)
    end
    if(@event.event_types)
      @event_types = EventType.find(@event.event_types)
    end
    @site= "<a href='https://"+@event.website.to_s+"'> </a>"
  end




  def index

    @filterrific = Filterrific.new(Event, params[:filterrific])
    

    @filterrific.select_options = {
      event_activities: EventActivity.all,
      with_game_id: EventActivity.options_for_select,
      with_event_type_id: EventType.options_for_select,
      sorted_by: Event.options_for_sorted_by,
      ends_after_yesterday: ""
    }


    @events = Event.filterrific_find(@filterrific).page(params[:page])


    @event_activities = EventActivity.all

    respond_to do |format|
      format.html
      format.js
    end
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





  private
  
  def sort_column
    Event.column_names.include?(params[:sort]) ? params[:sort] : "dayof"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def filter_by_game
    if
      params[:game_type]
    else
      ""
    end
  end


end
