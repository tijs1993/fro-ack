'use strict'

angular.module 'projectApp'
.controller 'accountSetupCtrl', ($scope, $http, Auth, $location, $window) ->
  $scope.getCurrentUser = Auth.getCurrentUser;

  toUTCDate = (date)->
    _utc = new Date(date.getFullYear(), date.getMonth(), date.getDate(),  date.getHours()+1, date.getMinutes(), date.getSeconds());
    return _utc;

  $scope.saveExtraData = (form) ->
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
    isOnline: true

