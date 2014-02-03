App.controller 'GraphsCtrl', ['$scope', 'Graph', ($scope, Graph) ->
  $scope.responses = Graph.query
]