'use strict'

angular.module 'projectApp'
.controller 'NavbarCtrl', ($scope, $location, Auth) ->
  $scope.menu = [{
    title: 'Oorsprong van energie'
    link: '/'
  },
    {
      title: 'Energie besparen'
      link: '/energiebesparen'
    }]

  $scope.isCollapsed = true
  $scope.isLoggedIn = Auth.isLoggedIn
  $scope.isAdmin = Auth.isAdmin
  $scope.getCurrentUser = Auth.getCurrentUser
  $scope.isLocalUser = Auth.isLocalUser

  $scope.logout = ->
    Auth.logout()
    $location.path '/login'

  $scope.isActive = (route) ->
    route is $location.path()