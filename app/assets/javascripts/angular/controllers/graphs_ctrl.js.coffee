App.controller 'GraphCtrl', ['$scope', 'DailyGraph', 'HourGraph', 'ProjectResponseCount', ($scope, DailyGraph, HourGraph, ProjectResponseCount) ->
  $scope.dayData = []
  $scope.hourData = []
  $scope.COUNT = 0

  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    $scope.fetchData()
    
    items = []
    if items.length == 0
      items.push ({ value: $scope.COUNT, timestamp: new Date() })
    $scope.chart = 
      {
        data: items
        max: 30
      } 
    socket = io.connect("//localhost:3001/")
    socket.on "message", (data) ->
      data = JSON.parse(data)
      if data.count != 0
        $scope.COUNT = data.count
      items.push { value: $scope.COUNT, timestamp: new Date() }
      #items.shift()  if items.length > 40
      $scope.chart = 
        {
          data: items
          max: 500
        }
      $scope.$apply()
 
  $scope.fetchData = ->
    DailyGraph.query( {"project_id": $scope.project_id}, (result) ->
      hash = result[0]
      for k, v of hash
        if k[0] != '$'
          $scope.dayData.push {time:k , data:v}
    )
        
    HourGraph.query( {"project_id": $scope.project_id}, (result) ->
      array = []
      for key, value of result[0]  
        if key[0] != '$'
          array.push {time: key, data: value}
      first = array[0..13]
      second = array[14..23]
      $scope.hourData = second.concat first
    )
    
    ProjectResponseCount.query( {"project_id": $scope.project_id}, (result) ->
      for key, value of result[0] 
        if key[0] != '$'
          $scope.COUNT = value
    )
]


