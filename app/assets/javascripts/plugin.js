//= require jquery
//= require uikit
//= require angular

if(console === undefined){
  console = {}; console.log = function () { };
}

function tmp_log(content) {
  $("#tmp_logger").append("<h2>" + content + "</h2>");
}

var building = angular.module("building", []);

building.controller('main', ["$scope", "$http", "$interval", function ($scope, $http, $interval) {
  $scope.current_model = {};
  $scope.local_skps = [];

  $scope.bridge = function (action, param) {
    console.log('bridge  ' + action);
    window.location.href = "skp:" + action + "@" + param;
  }

  $scope.current_model_name_change = function () {
    $scope.bridge('current_model_name_change', $scope.current_model.name);
  }

  $scope.$watch('current_model', function (n, w) {
    tmp_log(n.name);
  })

  $scope.$watch('local_skps', function (n, w) {
    tmp_log(n[0].name);
  })

  $scope.bridge('initialization', '');
}]);

