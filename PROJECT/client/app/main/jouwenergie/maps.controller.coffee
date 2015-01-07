'use strict'

angular.module 'projectApp'
.controller 'mapsCtrl', ($scope, Auth, $location, $http) ->
  userId = Auth.getCurrentUser()._id;

  #VARS
  $scope.elecAverage = 0;
  electricityValues = [];
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
  );
  $http.get("/api/electricityvalue/"+userId).then( (values)->
    $scope.elecAverage = calculateAverage(values.data);
  );

  #Get all userdata
  $http.get('/api/extradata/').then( (usersdata)->
    usersArray = usersdata.data;
  );
  $http.get('/api/electricityvalue/').then( (values)->
    electricityValues = values.data;
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
              users.splice(index,1)
              break;
            else
              break;
    if users.length == 0
      $scope.customError = "Er werden geen waarden gevonden die voldoen aan uw zoekcriteria. Alle gebruikers zullen worden getoond.";
      users = usersArray;
    else
      $scope.customError = "";
    getJSONData(users);

  #FUNCTIONS
  getJSONData = (users) ->
    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
    for user in users
      elecValues = [];
      for elecValue in electricityValues
        if elecValue.accountId == user.accountId
          elecValues.push(elecValue);
      elecAverage = calculateAverage(elecValues);
      generateMaps(user, elecAverage);

  generateMaps = (user, elecAverage) ->
    if user.accountId == userId
      image = '/assets/images/markers/letter_h.png';
    else if $scope.elecAverage > elecAverage
      image = 'http://maps.google.com/mapfiles/ms/icons/green-dot.png';
    else
      image = 'http://maps.google.com/mapfiles/ms/icons/red-dot.png';
    locations.push([user._id,user.address.street, user.address.zipcode, user.address.city, user.address.country])
    urlForLatAndLong = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user.address.street + "+" + user.address.city + "+" + user.address.country + "&key=" + api;
    $.ajax
      url: urlForLatAndLong,
      dataType: 'json',
      async: false,
      success: (data) ->
        lat = data["results"][0]["geometry"]["location"]["lat"];
        long = data["results"][0]["geometry"]["location"]["lng"];
        showOnMap(lat, long, i, elecAverage);
    i++;

  showOnMap = (lat, long, i, elecAverage) ->
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
        content = "<div id='content'><h3>Gemiddelde verbruik/ dag: ";
        content += elecAverage;
        content += " kWh</h3><p>";
        content += locations[i][1];
        content += "<br />";
        content += locations[i][2];
        content += " ";
        content += locations[i][3];
        content += "</i></p></div>";
        infoWindow.setContent(content);
        infoWindow.open(map, marker);

    )(marker, i));
    map.fitBounds(bounds);

  calculateAverage = (values) ->
    if values.length != 0
      elecValue = 0;
      for value in values
        if value.previousValue isnt 0
          elecValue += value.currentValue - value.previousValue;
          elecValue = elecValue/(values.length - 1);
        else
          elecValue = 0;
      return Math.round(elecValue*10)/10;
    else
      return 0;

