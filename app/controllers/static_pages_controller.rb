class StaticPagesController < ApplicationController
  def home
    #
    if current_user
     @transactions = current_user.transactions.where(:status => 0).paginate(page: params[:page], per_page: 4)
     @transactions_by_date = @transactions.group_by(&:deadline)
     @date = params[:date] ? Date.parse(params[:date]) : Date.today
   end
   

   




   
   @locations = Event.all 
 

  
   @json = Gmaps4rails.build_markers(@locations) do |event, marker|
     
      
     if event.dayof + (7) >=Date.today 
       
  
         marker.lat event.latitude
         marker.lng event.longitude
         marker.title event.title
          marker.json({
                id:       event.id, 
                name:     event.title,
                location: event.address,
                website: event.website,
                time: (event.dayof-Date.today+7),
                cat: event.cat,
                date: event.dayof.month.to_s+'/'+event.dayof.day.to_s+'/'+event.dayof.year.to_s
              })
         if event.website ==nil
           event.website=' '
         end
         if event.title !=nil
           if event.desc !=nil

            event_imgs = ""
            
            event.eventActivityObjects.each do |event_activity|
              event_imgs += "<img src=\"" + event_activity.icon.url(:thumb) + "\">"
            end


            infowindow_html = "<div class=\"info-window\">" +
            "<h1><a href=\"/events/" + event.id.to_s + "\">"+event.title+"</a></h1>" + 
            "<p>" +event.dayof.month.to_s+"/"+event.dayof.day.to_s+"/"+event.dayof.year.to_s+"</p>" +
            "<p><a href=\"/events/" + event.id.to_s + "\">More Info</a></p>" + 
            "<div class='activities'>"+event_imgs+"</div>" +
            "</div>"

           marker.infowindow (
            infowindow_html
            )
           else
             marker.infowindow  event.desc
           end
           else
             if event.desc != nil
              marker.infowindow event.desc
              end
           end

              #Determine which image to use for the gmaps markers
             if event.cat =='view'
               url='/img/common/marker_red.png'
             elsif event.cat =='tournament'
               url='/img/common/marker_green.png'
             
             elsif event.cat =='con/pax'
               url='/img/common/marker_blue.png'
             else
               url='/img/common/marker_purple.png'
             end
           marker.picture({  
             
            
                  
                  
              'url' => url,  
              
              "width"=>  16,
              "height"=> 16
           })
           marker.title event.title
           marker.json({ title: event.title})
        
           end
      end 
    end

  def help
  end
  
  def about
  end
end
