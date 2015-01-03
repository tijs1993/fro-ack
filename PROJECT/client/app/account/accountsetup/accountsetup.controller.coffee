'use strict'

angular.module 'projectApp'
.controller 'accountSetupCtrl', ($scope, $http, Auth, $location, $window) ->
  $scope.getCurrentUser = Auth.getCurrentUser;

  userId = Auth.getCurrentUser()._id;
  $http.get('/api/extradata/'+userId).then( (val)->
    $scope.val = val;
    if $scope.val.data is '' || $scope.val.data is null
      #Empty datafields
    else
      $scope.user = $scope.val.data;
      $scope.user.birthday = new Date($scope.user.birthday);
  );

  toUTCDate = (date)->
    _utc = new Date(date.getFullYear(), date.getMonth(), date.getDate(),  date.getHours()+1, date.getMinutes(), date.getSeconds());
    return _utc;

  $scope.saveExtraData = (form) ->
    if typeof $scope.user is 'undefined'
      console.log("no data filled in");
    else
      if typeof $scope.user._id is 'undefined' || $scope.user._id is '' || $scope.user._id is null
        #INSERT NEW DATA
        $http.post '/api/extradata',
          address:
            street: $scope.user.address.street
            number: $scope.user.address.number
            zipcode: $scope.user.address.zipcode
            city: $scope.user.address.city
            country: $scope.user.address.country
          birthday: toUTCDate($scope.user.birthday)
          numberOfResidents: $scope.user.numberOfResidents
          meterType: $scope.user.meterType
          insulation: $scope.user.insulation
          typeOfHeating: $scope.user.typeOfHeating
          sizeOfBuilding: $scope.user.sizeOfBuilding
          accountId: Auth.getCurrentUser()._id
          isOnline: true;
      else
        #UPDATE EXISTING DATA
        console.log("update");

    #redirect to energie-page
    $http.get '/jouwenergie';

