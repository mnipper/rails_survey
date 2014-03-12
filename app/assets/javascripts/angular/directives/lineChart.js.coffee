App.directive "scLineChart", ->
  template: "<div></div>"
  scope:
    chart: "="
  restrict: "E"
  replace: true
  link: postLink = (scope, element) ->
    draw = (chart) ->
      
      data = chart.data
      #console.log data + " is the current data"
      
      table = new google.visualization.DataTable()
      table.addColumn "datetime"
      table.addColumn "number"
      table.addRows data.length
      #console.log table + " is the table"
      
      view = new google.visualization.DataView(table)
      
      i = 0
      while i < data.length
        item = data[i]
        #console.log item + " is the item"
        #console.log item.value + " is the item value"
        #console.log item.timestamp + " is the item timestamp"
        
        table.setCell(i, 0, new Date(item.timestamp))
        value = parseFloat(item.value)
        table.setCell(i, 1, value)
        i++
        
      last = data[data.length - 1]
      max = new Date(last.timestamp)
      min = new Date(last.timestamp - chart.max * 1000)
      
      chartOptions =
        legend: "none"
        vAxis:
          minValue: 0
          maxValue: 100

        hAxis:
          viewWindow:
            min: min
            max: max

      lineChart.draw view, chartOptions

    lineChart = new google.visualization.LineChart(element[0])
    scope.$watch "chart", (chart) ->
      draw chart  if chart and chart.data and chart.max
