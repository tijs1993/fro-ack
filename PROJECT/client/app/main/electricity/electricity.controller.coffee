'use strict'

angular.module 'projectApp'
.controller 'electricityCtrl', ($scope,$http,Auth,$location) ->
  $scope.getCurrentUser = Auth.getCurrentUser;
  userId = Auth.getCurrentUser()._id;
  $scope.date = new Date();
  $scope.elecValues = [];
  $scope.error = "";
  isSameDay = false;
  $http.get('/api/electricityvalue/findone/'+userId).then((value) ->
    if value.data is '' || value.data is null || Object.getOwnPropertyNames(value.data).length is 1
      $scope.prevValue = 0;
    else
      $scope.prevValue = value.data[0].currentValue;
  );
  $http.get('/api/electricityvalue/findall/'+userId).then((value) ->
    $scope.elecValues = value.data;
  );

  $http.get('/api/extradata/'+userId).then( (val)->
    $scope.val = val;
    if $scope.val.data is '' || $scope.val.data is null
      $scope.customError = true;
    else
      $scope.customError = false;
      if $scope.val.data.meterType == "dubbel"
        $scope.meterType = "dubbel";
  );

  #$scope.meterType = "dubbel";

  $scope.saveElectricityValues = (form) ->
    if $scope.val.data.meterType == "dubbel"
      elecValue = parseFloat($scope.dayMeter) + parseFloat($scope.nightMeter);
    else
      elecValue = parseFloat($scope.dayMeter);
    # DO SEARCH FOR EXISTING DATES
    if $scope.elecValues.length is 0
    else
      for value in $scope.elecValues
        date = new Date(value.measureday);
        valueDate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
        formDate = new Date($scope.date.getFullYear(), $scope.date.getMonth(),$scope.date.getDate());
        if valueDate.getTime() == formDate.getTime()
          isSameDay = true;
          $scope.error = "U hebt reeds de waarden doorgegeven voor deze dag.";
      if isSameDay == false
        $http.post '/api/electricityvalue',
          measureday: $scope.date
          currentValue: elecValue
          previousValue: $scope.prevValue
          accountId: Auth.getCurrentUser()._id
        $location.path '/jouwenergie'
