// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  angular.module('projectApp').controller('accountSetupCtrl', function($scope, $http, Auth, $location, $window) {
    var toUTCDate, userId;
    $scope.getCurrentUser = Auth.getCurrentUser;
    userId = Auth.getCurrentUser()._id;
    $http.get('/api/extradata/' + userId).then(function(val) {
      $scope.val = val;
      if ($scope.val.data === '' || $scope.val.data === null) {

      } else {
        $scope.user = $scope.val.data;
        return $scope.user.birthday = new Date($scope.user.birthday);
      }
    });
    toUTCDate = function(date) {
      var _utc;
      _utc = new Date(date.getFullYear(), date.getMonth(), date.getDate(), date.getHours() + 1, date.getMinutes(), date.getSeconds());
      return _utc;
    };
    return $scope.saveExtraData = function(form) {
      if (typeof $scope.user === 'undefined') {
        console.log("no data filled in");
      } else {
        if (typeof $scope.user._id === 'undefined' || $scope.user._id === '' || $scope.user._id === null) {
          $http.post('/api/extradata', {
            address: {
              street: $scope.user.address.street,
              number: $scope.user.address.number,
              zipcode: $scope.user.address.zipcode,
              city: $scope.user.address.city,
              country: $scope.user.address.country
            },
            birthday: toUTCDate($scope.user.birthday),
            numberOfResidents: $scope.user.numberOfResidents,
            meterType: $scope.user.meterType,
            insulation: $scope.user.insulation,
            typeOfHeating: $scope.user.typeOfHeating,
            sizeOfBuilding: $scope.user.sizeOfBuilding,
            accountId: Auth.getCurrentUser()._id,
            isOnline: true
          });
        } else {
          console.log("update");
          $http.put('/api/extradata/update', {
            _id: $scope.user._id,
            address: {
              street: $scope.user.address.street,
              number: $scope.user.address.number,
              zipcode: $scope.user.address.zipcode,
              city: $scope.user.address.city,
              country: $scope.user.address.country
            },
            birthday: toUTCDate($scope.user.birthday),
            numberOfResidents: $scope.user.numberOfResidents,
            meterType: $scope.user.meterType,
            insulation: $scope.user.insulation,
            typeOfHeating: $scope.user.typeOfHeating,
            sizeOfBuilding: $scope.user.sizeOfBuilding,
            accountId: Auth.getCurrentUser()._id,
            isOnline: true
          });
        }
      }
      return $location.path('/jouwenergie');
    };
  });

}).call(this);

//# sourceMappingURL=accountsetup.controller.js.map
