'use strict'

angular.module 'projectApp'
.controller 'energieBesparenCtrl', ($scope) ->

	$scope.btn1click = ->
		console.log test

	$scope.btn2click = ->
		console.log 'test2'

	$scope.btn3click = ->
	    console.log 'test3'
	
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