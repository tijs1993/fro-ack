'use strict'

angular.module 'projectApp'
.controller 'energieBesparenCtrl', ($scope) ->
	
	$scope.toggleTipsCategorie1On = ->	
		$scope.btn1click = false;
		$scope.btn2click = true;
		$scope.btn3click = true;	
	
	$scope.toggleTipsCategorie2On = ->	
		$scope.btn1click = true;
		$scope.btn2click = false;
		$scope.btn3click = true;


	$scope.toggleTipsCategorie3On = ->
		$scope.btn1click = true;
		$scope.btn2click = true;
		$scope.btn3click = false;