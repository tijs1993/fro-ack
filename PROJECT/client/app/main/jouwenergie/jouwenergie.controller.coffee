'use strict'

angular.module 'projectApp'
.controller 'jouwenergieCtrl', ($scope) ->
  console.log('test');
  new Chartist.Bar('.ct-chart', {
    labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
    series: [
      [2, 3, 2, 4, 5,3,2]
    ]
  }, {
    seriesBarDistance: 30,
    axisX: {
      showGrid: false
    }
    width:750,
    height:500
  });