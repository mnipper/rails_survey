App.controller 'ProjectsCtrl', ['$scope', '$location', 'Project', ($scope, $location, Project) ->
  $scope.projects = Project.query()

  $scope.viewProject = (projectId) ->
    $location.path('/projects/'+projectId)

  $scope.viewInstruments = ->
    $location.path('/instruments')
]