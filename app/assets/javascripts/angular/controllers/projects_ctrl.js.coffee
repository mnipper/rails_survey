App.controller 'ProjectsCtrl', ['$scope', '$location', 'Project', ($scope, $location, Project) ->
  $scope.projects = Project.query()

  $scope.viewProject = (projectId) ->
    $location.url('/projects/'+projectId).replace()

  $scope.viewInstruments = ->
    $location.url('/instruments').replace()
]