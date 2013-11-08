
$(function(){
    var xAxisLabels;
    var seriesData = [[]];
    var labels = [];
    var myArrayString = $("#bar-responses").text();
    myArrayString = myArrayString.trim();
    var myArray = myArrayString.split(",");
    for (var k = 0; k < myArray.length; k++){
        var myStringArray = myArray[k].split("=>");
        seriesData[0].push({x: k, y: parseInt(myStringArray[1]) });
        myStringArray[0].trim();
        labels[k] = myStringArray[0].substring(3, myStringArray[0].length - 1);
    }

    var barGraph;
    try {
        barGraph = new Rickshaw.Graph({
            element: document.getElementById("survey-bar-chart"),
            height: 300,
            renderer: 'bar',
            series: [
                {
                    color: "blue",
                    data: seriesData[0]
                }
            ]
        });
        barGraph.render();
    }
    catch(err) {}

    xAxisLabels = function (n) {
        var map = { };
        for (var i = 0; i < labels.length; i++) {
            map[i] = labels[i];
        }
        return map[n];
    };

    var xAxisBar;
    xAxisBar = new Rickshaw.Graph.Axis.X({
        graph: barGraph,
        element: document.getElementById("survey-bar-chart-x"),
        tickFormat: xAxisLabels
    });
    xAxisBar.render();

    var yAxisBar;
    yAxisBar = new Rickshaw.Graph.Axis.Y({
        graph: barGraph,
        element: document.getElementById("survey-bar-chart-y"),
        orientation: "left",
        tickFormat: Rickshaw.Fixtures.Number.formatKMBT
    })
    yAxisBar.render();

});