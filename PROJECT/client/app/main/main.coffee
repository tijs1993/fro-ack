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
  .when '/water-energie',
    templateUrl: 'app/main/waterEnergie/waterenergie.html'
  .when '/wind-energie',
    templateUrl: 'app/main/windEnergie/windenergie.html'
  .when '/geschiedenis',
    templateUrl: 'app/main/geschiedenisEnergie/geschiedenisenergie.html'
  .when '/jouwenergie',
    templateUrl: 'app/main/jouwenergie/jouwenergie.html'
    controller: 'jouwEnergieCtrl'
    authenticate: true
  .when '/maps',
    templateUrl: 'app/main/jouwEnergie/maps.html'
    controller: 'mapsCtrl'
    authenticate: true
  .when '/elektriciteitsmeter',
    templateUrl: 'app/main/electricity/electricity.html'
    controller: 'electricityCtrl'
    authenticate: true
  .when '/404',
    templateUrl: 'app/errors/404/404.html'  