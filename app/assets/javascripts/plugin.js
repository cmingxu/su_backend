//= require jquery
//= require uikit
//= require angular

var building = angular.module("building", []);

building.controller('main', ["$scope", "$http", "$interval", function ($scope, $http, $interval) {
  $scope.current_model = {};
  $scope.local_skp_names = "";

  $scope.bridge = function (action, param) {
    console.log('bridge  ' + action);
    window.location.href = "skp:" + action + "@" + param;
  }

  $scope.bridge('current_model', '');

  $interval(function () {
      console.log($scope.current_model);
  }, 10 * 1000);

}]);

