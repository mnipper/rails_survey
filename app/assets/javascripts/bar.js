
$(function(){
    var xAxisLabels;
    var seriesData = [[]];
    var labels = [];
    var myArrayString = $("#bar-responses").text();
    myArrayString = myArrayString.trim();
    var myArray = myArrayString.split(",");

    for (var k = 0; k < myArray.length; k++){
        myArray[k].replace("");
        var myString = myArray[k].replace("{","");
        myString = myArray[k].replace("}","");
        myString = myArray[k].replace("[","");
        myString = myArray[k].replace("[","");
        var myStringArray = myString.split("=>");
        seriesData[0].push({x: k, y: parseInt(myStringArray[1]) });
        myStringArray[0].trim();
        labels[k] = myStringArray[0].substr(1);
    }

    var barGraph = new Rickshaw.Graph({
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

});