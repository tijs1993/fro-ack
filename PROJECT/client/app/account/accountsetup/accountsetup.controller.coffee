'use strict'

angular.module 'projectApp'
.controller 'accountSetupCtrl', ($scope, Auth, $location, $window) ->
  console.log("test");
  $scope.getCurrentUser = Auth.getCurrentUser;