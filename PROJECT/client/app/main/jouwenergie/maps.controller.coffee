'use strict'

angular.module 'projectApp'
.controller 'mapsCtrl', ($scope, Auth, $location, $http) ->
  userId = Auth.getCurrentUser()._id;

  #VARS
  $scope.formvalue = {};
  $scope.formvalue.numberOfResidents = "";
  $scope.formvalue.meterType = "0";
  $scope.formvalue.insulation = "0";
  $scope.formvalue.sizeOfBuilding = "0";
  $scope.formvalue.typeOfHeating = "0";
  $scope.customError = "";
  api = "AIzaSyDiPv6sSKzmOR1INjC_9kHxUY6bpwKOXHc";
  map;
  usersArray = [];
  i = 0;
  bounds = new google.maps.LatLngBounds();
  mapOptions = {
    zoom: 10
  };
  image = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
  locations = [];
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  $http.get('/api/extradata/'+userId).then( (userdata)->
    $scope.user = userdata.data;
    #console.log($scope.user);
  );

  #Get all userdata
  $http.get('/api/extradata/').then( (usersdata)->
    usersArray = usersdata.data;
    getJSONData(usersArray);
  );


  #Change-functions
  $scope.changed = ()->
    users = [];
    for user in usersArray
      for datafield of $scope.formvalue
        if $scope.formvalue[datafield] != "" && $scope.formvalue[datafield] != "0"
          if user[datafield] == $scope.formvalue[datafield]
            if user not in users
              users.push(user);
          else
            if user in users
              index = users.indexOf(user);
              console.log(index);
              users.splice(index,1)
              break;
            else
              break;
    console.log(users);
    if users.length == 0
      console.log("customError");
      $scope.customError = "Er werden geen waarden gevonden die voldoen aan uw zoekcriteria. Alle gebruikers zullen worden getoond.";
      users = usersArray;
    else
      $scope.customError = "";
    getJSONData(users);

  #FUNCTIONS
  getJSONData = (users) ->
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    #console.log(users)
    for user in users
      if user.accountId == userId
        image = '/assets/images/markers/letter_h.png';
      else
        image = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
      locations.push([user._id,user.address.street, user.address.zipcode, user.address.city, user.address.country])
      urlForLatAndLong = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user.address.street + "+" + user.address.city + "+" + user.address.country + "&key=" + api;
      #console.log(urlForLatAndLong);
      $.ajax
        url: urlForLatAndLong,
        dataType: 'json',
        async: false,
        success: (data) ->
          lat = data["results"][0]["geometry"]["location"]["lat"];
          long = data["results"][0]["geometry"]["location"]["lng"];
          #console.log(lat + "; "+long)
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

