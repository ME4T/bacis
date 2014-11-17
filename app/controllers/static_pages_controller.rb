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
                types: event.eventTypeObjects,
                date: event.dayof.month.to_s+'/'+event.dayof.day.to_s+'/'+event.dayof.year.to_s
              })
         if event.website ==nil
           event.website=' '
         end

         types_html = ""
         for type in event.eventTypeObjects
          types_html += "<img src = \"" + type.icon.url(:thumb) + "\" class=\"icon tooltipper\" data-tooltip=\"" + type.name + "\" />"
         end

          infowindow_html = 
            "<div class=\"info-window\">" + 
            "<h1><a href=\"/events/" + event.id.to_s + "\">"+event.title+"</a></h1>" +
            "<p>" + event.dayof.month.to_s+"/"+event.dayof.day.to_s+"/"+event.dayof.year.to_s+" - " + 
            event.end_date.month.to_s+"/"+event.end_date.day.to_s+"/"+event.end_date.year.to_s+"</p>" + 
            "<div>" + types_html + "</div>" +
            "<a href=\"/events/" + event.id.to_s + "\" class=\"more-info\">More Info</a>" +
            "</div>"

          marker.infowindow (
            infowindow_html
          )
             

              #Determine which image to use for the gmaps markers
              if event.dayof < Date.today+7;
                url='/img/common/marker_red.png'
              elsif event.dayof < Date.today+30;
                url='/img/common/marker_green.png'
              else
               url='/img/common/marker_blue.png'
             end
             
           marker.picture({  
              'url' => url,  
              "width"=>  32,
              "height"=> 32
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
