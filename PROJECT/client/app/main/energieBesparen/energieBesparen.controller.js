// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  angular.module('projectApp').controller('energieBesparenCtrl', function($scope) {
    $scope.btn1click = true;
    $scope.btn2click = true;
    $scope.btn3click = true;
    $scope.toggleTipsCategorie1On = function() {
      $scope.btn1click = false;
      $scope.btn2click = true;
      return $scope.btn3click = true;
    };
    $scope.toggleTipsCategorie2On = function() {
      $scope.btn1click = true;
      $scope.btn2click = false;
      return $scope.btn3click = true;
    };
    return $scope.toggleTipsCategorie3On = function() {
      $scope.btn1click = true;
      $scope.btn2click = true;
      return $scope.btn3click = false;
    };
  });

}).call(this);

//# sourceMappingURL=energieBesparen.controller.js.map
