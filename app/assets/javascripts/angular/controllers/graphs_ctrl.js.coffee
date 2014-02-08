App.controller 'GraphsCtrl', ['$scope', 'Graph', ($scope, Graph) ->
  $scope.data = []
  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    Graph.query( {"project_id": project_id}, (result) ->
      hash = result[0]
      for k, v of hash
        if k[0] != '$'
          $scope.data.push {time:k , data:v}
    )
  #$scope.data = [{time: "2014-01-31 00:00:00 UTC", data: 18}, {time: "2014-02-02 00:00:00 UTC", data: 6}, {time: "2014-02-03 00:00:00 UTC", data: 10}]
]