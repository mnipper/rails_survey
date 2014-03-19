App.directive 'scGraphResponses', [ ->
  return {
    restrict: 'E',
    scope: {val: '='},
    transclude: true,
    replace: true,
    link: (scope, element, attrs) ->
      createGraph(scope, element)
      scope.$watch('val', updateGraph, true)
  }
]

createGraph = (scope, element) ->
  scope.w = 700
  scope.h = 400
  scope.padding =
      top: 20
      right: 20
      bottom: 30
      left: 30
  scope.innerHeight = scope.h - scope.padding.bottom - scope.padding.top
  scope.innerWidth = scope.w - scope.padding.left - scope.padding.right

  if not scope.svg?
    scope.svg = d3.select(element[0])
    .append("svg")
    .attr("width", scope.w)
    .attr("height", scope.h)
    .append("g")
    .attr("transform", "translate(" + scope.padding.left + ", " + scope.padding.top + ")")
    .style("width", scope.w)
    .style("height", scope.h)
  
updateGraph = (newVal, oldVal, scope) ->
    scope.xLabels = newVal.map (pair) -> pair.time
    scope.xScale = d3.scale.ordinal().domain(d3.range(newVal.length)).rangeRoundBands([0, scope.w], 0.05)
    scope.yScale = d3.scale.linear().domain([0, d3.max(newVal, (d) -> d.data)]).range([scope.innerHeight, 0])

    scope.xAxis = d3.svg.axis().scale(scope.xScale).orient("bottom").tickFormat((d) -> scope.xLabels[d])
    scope.yAxis = d3.svg.axis().scale(scope.yScale).orient("left").ticks(5)

    scope.svg.selectAll("rect")
      .data(newVal, (d) -> d.time)
      .enter()
      .append("rect")
      .attr("x", (d, i) -> scope.xScale i)
      .attr("y", (d) -> scope.yScale(d.data))
      .attr("width", scope.xScale.rangeBand())
      .attr("height", (d) -> scope.innerHeight - scope.yScale(d.data))
      .attr("fill", (d) -> "rgb(#{0}, #{0}, #{d.data*10})")
 
    scope.svg.append("g")
      .attr("class", "axis")
      .attr("transform", "translate(#{0},#{scope.innerHeight})")
      .call(scope.xAxis)
      
    scope.svg.append("g")
      .attr("class", "axis")
      .attr("transform", "translate(" + 0 + ",0)")
      .call(scope.yAxis)
