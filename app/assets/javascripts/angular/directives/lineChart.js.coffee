App.directive "scLineChart", ->
  template: "<div></div>"
  scope:
    chart: "="
  restrict: "E"
  replace: true
  link: postLink = (scope, element) ->
    draw = (chart) ->
      dataTotal = chart.totalCount
      dataDifference = chart.differenceCount
      
      table = new google.visualization.DataTable()
      table.addColumn "datetime", "Time"
      table.addColumn "number", "Total Responses"
      table.addColumn "number", "Change in Responses"
      table.addRows dataTotal.length
      
      view = new google.visualization.DataView(table)

      i = 0
      while i < dataTotal.length and i < dataDifference.length
        item = dataTotal[i] 
        diff = dataDifference[i]   
        table.setCell(i, 0, new Date(item.timestamp))
        totalFloat = parseFloat(item.value)
        diffFloat = parseFloat(diff.value)
        table.setCell(i, 1, totalFloat)
        table.setCell(i, 2, diffFloat)
        i++
        
      last = dataTotal[dataTotal.length - 1]
      max = new Date(last.timestamp)
      min = new Date(last.timestamp - chart.max * 1000)
      
      chartOptions =
        legend: 
          position: "bottom" 
        title: "Realtime Project Responses Summary"
        titlePosition: "out"
        series: 
          [
            { targetAxisIndex: 0, color: 'blue' },
            { targetAxisIndex: 1, color: 'red' }
          ]
        vAxes:
          [
           { title: 'Total Responses', minValue: 0, maxValue: 100 }, 
           { title: 'Change in Responses', minValue: 0, maxValue: 20 }
          ]
        hAxis:
          viewWindow:
            min: min
            max: max
          title: "Time"
        backgroundColor: "#339999"
        chartArea: 
          width: 750

      lineChart.draw view, chartOptions

    lineChart = new google.visualization.LineChart(element[0])
    scope.$watch "chart", (chart) ->
      draw chart  if chart and chart.totalCount and chart.max and chart.differenceCount
