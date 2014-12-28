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
  .when '/jouwenergie',
    templateUrl: 'app/main/jouwenergie/jouwenergie.html'
    controller: 'jouwEnergieCtrl'
  .when '/maps',
    templateUrl: 'app/main/jouwEnergie/maps.html'
    controller: 'mapsCtrl'
  .when '/404',
    templateUrl: 'app/errors/404/404.html'


