'use strict'

angular.module 'projectApp'
.config ($routeProvider) ->
  $routeProvider
  .when '/login',
    templateUrl: 'app/account/login/login.html'
    controller: 'LoginCtrl'

  .when '/signup',
    templateUrl: 'app/account/signup/signup.html'
    controller: 'SignupCtrl'

  .when '/settings',
    templateUrl: 'app/account/settings/settings.html'
    controller: 'SettingsCtrl'
    authenticate: true

  .when '/accountsetup',
    templateUrl: 'app/account/accountsetup/accountsetup.html'
    controller: 'accountSetupCtrl'
    authenticate: true
  .when '/userdata',
    templateUrl: 'app/account/settings/userdata.html'
    controller: 'userDataCtrl'
    authenticate: true