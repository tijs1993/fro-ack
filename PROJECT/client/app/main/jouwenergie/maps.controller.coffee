'use strict'

angular.module 'projectApp'
.controller 'mapsCtrl', ($scope, Auth, $location, $http) ->
  userId = Auth.getCurrentUser()._id;

  #VARS
  api = "AIzaSyDiPv6sSKzmOR1INjC_9kHxUY6bpwKOXHc";
  map;
  i = 0;
  bounds = new google.maps.LatLngBounds();
  mapOptions = {
    zoom: 10
  };
  image = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
  locations = [];
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  $http.get('/api/extradata/').then( (userdata)->
    $scope.userdata = userdata;
    for user in $scope.userdata.data
      if user.accountId == userId
        image = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
      else
        image = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
      locations.push([user._id,user.address.street, user.address.zipcode, user.address.city, user.address.country])
  );

  #FUNCTIONS
  getJSONData = () ->
    console.log(locations);
    for user in $scope.userdata.data
      if user.accountId == userId
        image = '/assets/images/markers/letter_h.png';
      else
        image = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
      #locations.push([user._id,user.address.street, user.address.zipcode, user.address.city, user.address.country])
      urlForLatAndLong = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user.address.street + "+" + user.address.city + "+" + user.address.country + "&key=" + api;
      $.ajax
        url: urlForLatAndLong,
        dataType: 'json',
        async: false,
        success: (data) ->
          lat = data["results"][0]["geometry"]["location"]["lat"];
          long = data["results"][0]["geometry"]["location"]["lng"];
          showOnMap(lat, long, i);
      i++;

  showOnMap = (lat, long, i) ->
    myLatLng = new google.maps.LatLng(lat, long);
    bounds.extend(myLatLng);
    marker = new google.maps.Marker(
      position: myLatLng
      map: map
      icon: image;
    );
    infoWindow = new google.maps.InfoWindow();
    marker;
    google.maps.event.addListener(marker, 'click', ((marker, i) ->
      ->
        content = "<div id='content'>" +
                "<h1>" + locations[i][0] + "</h1>" +
                "<p><i>" + locations[i][1] + "<br />" +
                locations[i][2] + " " + locations[i][3] + "</i></p>" +
                "</div>";
        infoWindow.setContent(content);
        infoWindow.open(map, marker);

    )(marker, i));
    map.fitBounds(bounds);

  google.maps.event.addDomListener(window, 'load', getJSONData);
