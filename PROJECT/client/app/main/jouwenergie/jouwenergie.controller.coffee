'use strict'

angular.module 'projectApp'
.controller 'jouwEnergieCtrl', ($scope, $http, Auth) ->
  dates = [];
  values = [];
  names = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
  userId = Auth.getCurrentUser()._id;
  $http.get('/api/extradata/'+userId).then( (userdata)->
    $scope.userdata = userdata;
    if $scope.userdata.data is '' || $scope.userdata.data is null
      console.log("No extra-userdata found");
      #Go back to the page for filling in the data
    else
      #load electricity-data
      $http.get('/api/electricityvalue/'+userId).then( (elecValues)->
        $scope.elecValues = elecValues;
        if $scope.elecValues.data is '' || $scope.elecValues.data is null
          console.log("No electricity-values found.");
        else
          ### USERDATA IS GEVONDEN + ELEKTRICITEITSWAARDEN GEVONDEN ###
          ### OPSTELLEN GRAFIEK ###

          # LABELS VOOR GRAFIEK INSTELLEN
          getLabelsForGraph(dates);

          # VALUES VOOR GRAFIEK INSTELLEN
          getValuesForGraph(dates);

          # GRAFIEK LADEN MET LABELS EN VALUES
          loadGraph(dates,values);
      );
  );

  getLabelsForGraph = (dates) ->
    ###
      DATUMLABELS AANMAKEN OP BASIS VAN HUIDIGE DAG
        1. datum van een week terug bepalen
        2. overlopen van de hele week
           2a. label-string opstellen
           2b. datum in label-array plaatsen
    ###
    date = new Date();
    date.setDate(date.getDate() - 6);
    while date <= new Date()
      dateValue = names[date.getDay()] + " " + date.getDate() + "/" + (date.getMonth() + 1);
      dates.push dateValue;
      date.setDate(date.getDate()+1);

  getValuesForGraph = (dates) ->
    ###
      WAARDEN OPVRAGEN UIT DATABASE OP BASIS VAN HUIDIGE DAG
        1. alle datums van de week overlopen (via label-array)
           1a. Bool aanmaken
           1b. array met datums uit database overlopen
               1ba. controle of datum van de week overeenkomt met datum uit de database
               1bb. indien ja: bool op true zetten
           1c. controle of bool true of false is om value te stockeren in array
    ###
    for dateOfWeek in dates
      bool = false;
      for elecValue in $scope.elecValues.data
        date = new Date(elecValue.measureday);
        dateName = names[date.getDay()] + " " + date.getDate() + "/" +(date.getMonth()+1);
        if dateName == dateOfWeek
          bool = true;
          break;
      if bool == true
        if elecValue.previousValue == 0
          values.push '0'
        else
          values.push (elecValue.currentValue - elecValue.previousValue);
      else
        values.push '0';

  loadGraph = (dates,values) ->
    new Chartist.Bar('.ct-chart', {
      labels: dates,
      series: [
        values
      ]
    }, {

      axisX: {
        showGrid: false
      }
      width:650,
      height:500
    });
