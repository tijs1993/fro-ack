'use strict'

angular.module 'projectApp'
.controller 'SettingsCtrl', ($scope, User, Auth) ->
  #console.log(Auth.getCurrentUser());
  $scope.errors = {}
  $scope.changePassword = (form) ->
    $scope.submitted = false

    if form.$valid
      Auth.changePassword $scope.user.oldPassword, $scope.user.newPassword
      .then ->
        $scope.message = 'Password successfully changed.'

      .catch ->
        form.password.$setValidity 'mongoose', false
        $scope.errors.other = 'Incorrect password'
        $scope.message = ''
