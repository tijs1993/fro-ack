'use strict'

angular.module 'projectApp'
.controller 'mapsCtrl', ($scope) ->
  api = "AIzaSyDiPv6sSKzmOR1INjC_9kHxUY6bpwKOXHc";
  map;
  bounds = new google.maps.LatLngBounds();
  mapOptions = {
    zoom: 15
  };
  image = 'icon.png';
  locations = [
    ["Campus GKG", "Graaf Karel de Goedelaan 5", "8500", "Kortrijk", "Belgium", "1"],
    ["Campus RDR", "Renaat de Rudderlaan 6", "8500", "Kortrijk", "Belgium", "2"],
    ["Campus The Level", "Botenkopersstraat 2", "8500", "Kortrijk", "Belgium", '2'],
    ["Campus Rijselstraat", "Rijselstraat 5", "8200", "Brugge", "Belgium", "1"],
    ["Campus Sint-Jorisstraat", "Sint-Jorisstraat 71", "8000", "Brugge", "Belgium", "2"]
  ];

  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  getJSONData = ()->
    for location in locations
      urlForLatAndLong = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location[1] + "+" + location[3] + "+" + location[4] + "&key=" + api;
      console.log(urlForLatAndLong);
      $.ajax urlForLatAndLong,
        dataType: 'json',
        async: false,
        success: (data)->
          lat = data["results"][0]["geometry"]["location"]["lat"];
          long = data["results"][0]["geometry"]["location"]["lng"];
          showOnMap(lat, long, location);


  showOnMap = (lat, long, location)->
    myLatLng = new google.maps.LatLng(lat, long);
    bounds.extend(myLatLng);
    ###if location[5] == 1
      image = "icon.png";
    else
      image = "icon2.png";
###
    marker = new google.maps.Marker({
      position: myLatLng,
      map: map,
      #icon: image
    });

    infoWindow = new google.maps.InfoWindow();

    map.fitBounds(bounds);
  google.maps.event.addDomListener(window, 'load', getJSONData());
