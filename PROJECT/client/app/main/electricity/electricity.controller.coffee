'use strict'

angular.module 'projectApp'
.controller 'electricityCtrl', ($scope,$http,Auth,$location) ->
  $scope.getCurrentUser = Auth.getCurrentUser;
  userId = Auth.getCurrentUser()._id;
  $scope.date = new Date();
  $http.get('/api/electricityvalue/findone/'+userId).then((value) ->
    if value.data is '' || value.data is null || Object.getOwnPropertyNames(value.data).length is 1
      $scope.prevValue = 0;
    else
      $scope.prevValue = value.data[0].currentValue;
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
    elecValue = parseFloat($scope.dayMeter) + parseFloat($scope.nightMeter);
    # DO SEARCH FOR EXISTING DATES
    # IF VALUE FOUND -> message back, ELSE -> save
    $http.post '/api/electricityvalue',
      measureday: $scope.date
      currentValue: elecValue
      previousValue: $scope.prevValue
      accountId: Auth.getCurrentUser()._id

    $location.path '/jouwenergie';