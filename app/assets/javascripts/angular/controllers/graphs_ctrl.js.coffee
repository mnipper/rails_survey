App.controller 'GraphCtrl', ['$scope', 'DailyGraph', 'HourGraph', 'ProjectResponseCount', ($scope, DailyGraph, HourGraph, ProjectResponseCount) ->
  $scope.dayData = []
  $scope.hourData = []
  MAXIMUM = 1000
  totalCount = 0
  differenceCount = 0

  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    $scope.fetchData()
    $scope.lineGraph()
 
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
          totalCount = value
    )

  $scope.lineGraph = ->
    totalResponseCount = []
    differenceResponseCount = []
    if totalResponseCount.length == 0
      totalResponseCount.push ({ value: totalCount, timestamp: new Date() })
      differenceResponseCount.push ({ value: 0, timestamp: new Date() })
    $scope.chart = 
      {
        totalCount: totalResponseCount
        max: MAXIMUM
        differenceCount: differenceResponseCount
      } 
    socket = io.connect("//localhost:3001/")
    socket.on "message", (data) ->
      data = JSON.parse(data)
      if data.count != 0
        totalCount = data.count
        difference = parseInt(data.count) - parseInt(totalResponseCount[totalResponseCount.length - 1].value) 
        differenceCount = difference.toString()
      totalResponseCount.push { value: totalCount, timestamp: new Date() }
      differenceResponseCount.push { value: differenceCount, timestamp: new Date() }
      
      $scope.chart = 
        {
          totalCount: totalResponseCount
          max: MAXIMUM
          differenceCount: differenceResponseCount
        }
      $scope.$apply()
    
]


