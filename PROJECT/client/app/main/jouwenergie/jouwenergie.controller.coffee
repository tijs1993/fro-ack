'use strict'

angular.module 'projectApp'
.controller 'jouwEnergieCtrl', ($scope) ->
  new Chartist.Bar('.ct-chart', {
    labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
    series: [
      [0,0,11.1,11.1,0,0,0]
    ]
  }, {
    seriesBarDistance: 30,
    axisX: {
      showGrid: false
    }
    width:750,
    height:500
  });