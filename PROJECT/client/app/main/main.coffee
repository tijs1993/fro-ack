'use strict'

angular.module 'projectApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/',
    templateUrl: 'app/main/main.html'
    controller: 'MainCtrl'
  .when '/energiebesparen',
    templateUrl: 'app/main/energieBesparen/energiebesparen.html'
    controller: 'energieBesparenCtrl'
  .when '/zonne-energie',
  	templateUrl: 'app/main/zonneEnergie/zonneenergie.html'
  .when '/accountsetup',
  	templateUrl: 'app/account/accountsetup/accountsetup.html'
  .when '/jouwenergie',
  	templateUrl: 'app/main/jouwenergie/jouwenergie.html'

# CHARTJS DATA
new Chartist.Line('.ct-chart', {
  labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
  series: [
    [2, 3, 2, 4, 5],
    [0, 2.5, 3, 2, 3],
    [1, 2, 2.5, 3.5, 4]
  ]
}, {
  width: 320,
  height: 240
});