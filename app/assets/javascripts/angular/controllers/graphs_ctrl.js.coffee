App.controller 'GraphCtrl', ['$scope', 'DailyGraph', 'HourGraph', 'ProjectResponseCount', ($scope, DailyGraph, HourGraph, ProjectResponseCount) ->
  $scope.dayData = []
  $scope.hourData = []
  MAXIMUM = 100
  totalCount = 0
  differenceCount = 0
  previousTotalCount = 0
  reloadPage = false

  $scope.initialize = (project_id) ->
    $scope.project_id = project_id
    $scope.fetchData()
    $scope.lineGraph()
 
  $scope.fetchData = ->
    DailyGraph.query( {"project_id": $scope.project_id}, (result) ->
      array = []
      for k, v of result[0]
        if k[0] != '$'
          array.push {time:k , data:v}
      $scope.dayData = array
      $scope.refreshPage()
    )
        
    HourGraph.query( {"project_id": $scope.project_id}, (result) ->
      array = []
      for key, value of result[0]  
        if key[0] != '$'
          array.push {time: key, data: value}
      console.log array
      $scope.hourData = array
      console.log $scope.hourData 
      $scope.refreshPage()
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
    socket = io.connect('//wci-chpir.duke.edu:8080/') #TODO Extract
    socket.on "message", (data) ->
      data = JSON.parse(data)
      if data.count != 0
        totalCount = data.count
        differenceCount +=1
        $scope.fetchData() 
        reloadPage = true
      else
        if totalResponseCount.length >= 2 and totalResponseCount[totalResponseCount.length - 1].value == totalResponseCount[totalResponseCount.length - 2].value
            differenceCount = 0
      totalResponseCount.push { value: totalCount, timestamp: new Date() }
      differenceResponseCount.push { value: differenceCount, timestamp: new Date() }
      
      $scope.chart = 
        {
          totalCount: totalResponseCount
          max: MAXIMUM
          differenceCount: differenceResponseCount
        }
      $scope.$apply()
 
  $scope.refreshPage = ->
    currentPage = window.location.href
    currentPageArray = currentPage.split "/"
    if reloadPage == true and currentPageArray[currentPageArray.length - 1] == "daily"
      window.location.reload(false)
    
]


