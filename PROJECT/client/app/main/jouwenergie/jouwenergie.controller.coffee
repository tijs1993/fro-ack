'use strict'

angular.module 'projectApp'
.controller 'jouwEnergieCtrl', ($scope, $http, Auth) ->
  dates = [];
  values = [];
  names = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
  userId = Auth.getCurrentUser()._id;
  
  #console.log(userId);
  $http.get('/api/extradata/'+userId).then( (userdata)->
    $scope.userdata = userdata;
    if $scope.userdata.data is '' || $scope.userdata.data is null
      $scope.customError = "no-userdata";
    else
      #load electricity-data
      $http.get('/api/electricityvalue/'+userId).then( (elecValues)->
        $scope.elecValues = elecValues;
        if $scope.elecValues.data is '' || $scope.elecValues.data is null || Object.getOwnPropertyNames($scope.elecValues.data).length is 1
          $scope.customError = "no-elecData";
        else
          getLabelsForGraph(dates);
          getValuesForGraph(dates);
          loadGraph(dates,values);
      );
  );

  getLabelsForGraph = (dates) ->
    date = new Date();
    date.setDate(date.getDate() - 6);
    while date <= new Date()
      dateValue = names[date.getDay()] + " " + date.getDate() + "/" + (date.getMonth() + 1);
      dates.push dateValue;
      date.setDate(date.getDate()+1);

  getValuesForGraph = (dates) ->
    for dateOfWeek in dates
      bool = false;
      for elecValue in $scope.elecValues.data
        date = new Date(elecValue.measureday);
        dateName = names[date.getDay()] + " " + date.getDate() + "/" +(date.getMonth()+1);
        if dateName == dateOfWeek
          bool = true;
          break;
      if bool == true
        if elecValue.previousValue == 0
          values.push '0'
        else
          values.push (elecValue.currentValue - elecValue.previousValue);
      else
        values.push '0';

  loadGraph = (dates,values) ->
    new Chartist.Bar('.ct-chart', {
      labels: dates,
      series: [
        values
      ]
    }, {

      axisX: {
        showGrid: false
      }
      width:650,
      height:500
    });
