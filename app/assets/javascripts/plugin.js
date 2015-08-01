//= require jquery
//= require uikit
//= require angular

if(console === undefined){
  console = {}; console.log = function () { };
}

var building = angular.module("building", []);

building.controller('main', ["$scope", "$http", "$interval", function ($scope, $http, $interval) {
  $scope.current_model = {};
  $scope.local_skp_names = "";

  $scope.bridge = function (action, param) {
    console.log('bridge  ' + action);
    window.location.href = "skp:" + action + "@" + param;
  }

  $scope.current_model_name_change = function () {
    $scope.bridge('current_model_name_change', $scope.current_model.name);
  }

  $scope.$watch('current_model', function (n, w) {
   console.log(n, w);
  })

  $scope.bridge('initialization', '');
}]);

