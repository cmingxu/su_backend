#= require jquery
#= require uikit
#= require angular
#= require angular-resource


building = angular.module "building", ['ngResource']

building.config ['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

building.factory "Entity", ($resource) ->
  $resource("/api/entities/:id", {id: '@id'}, {
    index:
      method: 'GET'
      isArray: true
  })

building.controller "main", ['$scope', '$http', '$interval', "Entity", ($scope, $http, $interval, Entity) ->
  $scope.current_model = {}
  $scope.system_models = {}
  Entity.index (data) ->
    $scope.system_models = data
    console.log data

  $scope.bridge = (action, param) ->
    console.log 'bridge' + action
    window.location.href = "skp:" + action + "@" + param

  $scope.current_model_name_change = () ->
    $scope.bridge "current_model_name_change", $scope.current_model.name
]

