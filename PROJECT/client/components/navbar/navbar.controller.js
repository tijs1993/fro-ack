// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  angular.module('projectApp').controller('NavbarCtrl', function($scope, $location, Auth) {
    $scope.menu = [
      {
        title: 'Oorsprong van energie',
        link: '/'
      }, {
        title: 'Energie besparen',
        link: '/energiebesparen'
      }
    ];
    $scope.isCollapsed = true;
    $scope.isLoggedIn = Auth.isLoggedIn;
    $scope.isAdmin = Auth.isAdmin;
    $scope.getCurrentUser = Auth.getCurrentUser;
    $scope.isLocalUser = Auth.isLocalUser;
    $scope.logout = function() {
      Auth.logout();
      return $location.path('/login');
    };
    return $scope.isActive = function(route) {
      return route === $location.path();
    };
  });

}).call(this);

//# sourceMappingURL=navbar.controller.js.map
