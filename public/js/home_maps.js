$(document).ready(function(){
      




    function hide(category) {
        var regEx = new RegExp("[" + category + "]")
        for (var i=0; i<Gmaps.map.markers.length; i++) {
            if (Gmaps.map.markers[i].cat) {
                if (Gmaps.map.markers[i].cat.match(regEx)) {
                    Gmaps.map.hideMarker(Gmaps.map.markers[i]);
                    $('a#' + Gmaps.map.markers[i].id).closest('li').hide();
                    Gmaps.map.visibleInfoWindow.close();
                }
            }
        }
        // == clear the checkbox ==
        document.getElementById(category+"box").checked = false;
    };


    function resizeMap(){
        var desiredHeight = $(window).height() - $(".main-header").height() - 200;
        if(desiredHeight<300)
            desiredHeight = 300;
        
        console.log(desiredHeight)
        $("#the_map").height(desiredHeight+"px");


    }
    resizeMap();

    $( window ).resize(function() {
        resizeMap();
    });



    function show(category) {
        var regEx = new RegExp("[" + category + "]")
        for (var i=0; i<Gmaps.map.markers.length; i++) {
            if (Gmaps.map.markers[i].cat) {
                if (Gmaps.map.markers[i].cat.match(regEx)) {
                    Gmaps.map.hideMarker(Gmaps.map.markers[i]);
                    $('a#' + Gmaps.map.markers[i].id).closest('li').hide();
                    Gmaps.map.visibleInfoWindow.close();
                }
            }
        }
        // == clear the checkbox ==
        document.getElementById(category+"box").checked = true;
    }




    var gmaps_markers;




    function createSidebarLi(shop_json) {
        return ("<li><a>" + shop_json.title +  " - "+shop_json.date +' - ' + shop_json.location + "<\/a></li>");
    };
 


    function bindLiToMarker($li, marker){
        $li.click(function(){
            marker.panTo(); //to pan to the marker
            google.maps.event.trigger(marker.getServiceObject(), "click"); // to open infowindow
        });
    };

    function createSidebar(){
      
        for (var i=0;i<raw_markers.length;i++){
      
          
            if (raw_markers[i].time>0){
                var $li = $( createSidebarLi(raw_markers[i]) );
        
             
                $li.appendTo($('#sidebar_container'));
                bindLiToMarker($li, gmaps_markers[i]);
          }
      }
    };



    var options = {
        enableHighAccuracy: true,
        timeout: 5000,
        maximumAge: 0
    };

    function success(pos) {
        handler.map.centerOn(pos.coords.lat, pos.coords.lng)
    };

    function error(err) {
        console.warn('ERROR('+"User denied the request for Geolocation.)");
    };

    //navigator.geolocation.getCurrentPosition(success, error, options);

    handler = Gmaps.build('Google', {markers: { maxRandomDistance: 10000} });
    handler.buildMap({ provider: {zoom: 6, 'center': new google.maps.LatLng(30.26, -97.742)}, internal: {id: 'the_map'}}, function(){
        if(navigator.geolocation){
            navigator.geolocation.getCurrentPosition(displayOnMap);
        }
   
        function displayOnMap(position){
            var location = handler.addMarker({
                    lat: position.coords.latitude,
                    lng: position.coords.longitude,
                    picture: {
                        "url": 'http://www.revolutionarynj.org/wp-content/uploads/2013/01/13576186321669125115.png',
                        "width":  36,
                        "height": 36
                    },
                    infowindow: 'Current Location '
                });
            handler.map.centerOn(location);  
     
            gmaps_markers = handler.addMarkers(raw_markers); 
            createSidebar();
        };

    });


    
});