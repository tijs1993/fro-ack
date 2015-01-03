// Generated by CoffeeScript 1.8.0
(function() {
  'use strict';
  angular.module('projectApp').controller('jouwEnergieCtrl', function($scope, $http, Auth) {
    var dates, getLabelsForGraph, getValuesForGraph, loadGraph, names, userId, values;
    dates = [];
    values = [];
    names = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
    userId = Auth.getCurrentUser()._id;
    $http.get('/api/extradata/' + userId).then(function(userdata) {
      $scope.userdata = userdata;
      if ($scope.userdata.data === '' || $scope.userdata.data === null) {
        return console.log("No extra-userdata found");
      } else {
        return $http.get('/api/electricityvalue/' + userId).then(function(elecValues) {
          $scope.elecValues = elecValues;
          if ($scope.elecValues.data === '' || $scope.elecValues.data === null) {
            return console.log("No electricity-values found.");
          } else {

            /* USERDATA IS GEVONDEN + ELEKTRICITEITSWAARDEN GEVONDEN */

            /* OPSTELLEN GRAFIEK */
            getLabelsForGraph(dates);
            getValuesForGraph(dates);
            return loadGraph(dates, values);
          }
        });
      }
    });
    getLabelsForGraph = function(dates) {

      /*
        DATUMLABELS AANMAKEN OP BASIS VAN HUIDIGE DAG
          1. datum van een week terug bepalen
          2. overlopen van de hele week
             2a. label-string opstellen
             2b. datum in label-array plaatsen
       */
      var date, dateValue, _results;
      date = new Date();
      date.setDate(date.getDate() - 6);
      _results = [];
      while (date <= new Date()) {
        dateValue = names[date.getDay()] + " " + date.getDate() + "/" + (date.getMonth() + 1);
        dates.push(dateValue);
        _results.push(date.setDate(date.getDate() + 1));
      }
      return _results;
    };
    getValuesForGraph = function(dates) {

      /*
        WAARDEN OPVRAGEN UIT DATABASE OP BASIS VAN HUIDIGE DAG
          1. alle datums van de week overlopen (via label-array)
             1a. Bool aanmaken
             1b. array met datums uit database overlopen
                 1ba. controle of datum van de week overeenkomt met datum uit de database
                 1bb. indien ja: bool op true zetten
             1c. controle of bool true of false is om value te stockeren in array
       */
      var bool, date, dateName, dateOfWeek, elecValue, _i, _j, _len, _len1, _ref, _results;
      _results = [];
      for (_i = 0, _len = dates.length; _i < _len; _i++) {
        dateOfWeek = dates[_i];
        bool = false;
        _ref = $scope.elecValues.data;
        for (_j = 0, _len1 = _ref.length; _j < _len1; _j++) {
          elecValue = _ref[_j];
          date = new Date(elecValue.measureday);
          dateName = names[date.getDay()] + " " + date.getDate() + "/" + (date.getMonth() + 1);
          if (dateName === dateOfWeek) {
            bool = true;
            break;
          }
        }
        if (bool === true) {
          _results.push(values.push(elecValue.currentValue - elecValue.previousValue));
        } else {
          _results.push(values.push('0'));
        }
      }
      return _results;
    };
    return loadGraph = function(dates, values) {
      return new Chartist.Bar('.ct-chart', {
        labels: dates,
        series: [values]
      }, {
        seriesBarDistance: 30,
        axisX: {
          showGrid: false
        },
        width: 750,
        height: 500
      });
    };
  });

}).call(this);

//# sourceMappingURL=jouwenergie.controller.js.map
