building = angular.module "building", ['ngResource']

building.factory 'Entity', ($resource) ->
  $resource("/api/entities/:id", {id: '@id'})
