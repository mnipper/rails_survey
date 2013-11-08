
$(function(){
    var seriesData = [ [] ];
    var myData = $("#survey-line-data").text();
    myData = myData.trim();
    myData = myData.substring(1, myData.length - 1);
    var myDataArray = myData.split(",");
    for (var k = 0; k < myDataArray.length; k++) {
        var mySplitData = myDataArray[k].split("=>");
        seriesData[0].push({ x:parseInt(mySplitData[0].trim()), y:parseInt(mySplitData[1].trim()) });
    }

    var graph = new Rickshaw.Graph( {
        element: document.getElementById("survey-line-chart"),
        width: 400,
        height: 300,
        renderer: 'line',
        series: [
            {
                color: "#c05020",
                data: seriesData[0],
                name: 'responses by hour'
            }
        ]
    } );
    graph.render();

    var hoverDetail = new Rickshaw.Graph.HoverDetail( {
        graph: graph
    } );

    var legend = new Rickshaw.Graph.Legend( {
        graph: graph,
        element: document.getElementById('line-legend')

    } );

    var shelving = new Rickshaw.Graph.Behavior.Series.Toggle( {
        graph: graph,
        legend: legend
    } );

    var xAxisLabels = function (n) {
        var map = {};
        for (var i = 0; i < 24; i++) {
            map[i] = i;
        }
        return map[n];
    };

    var axes = new Rickshaw.Graph.Axis.X( {
        graph: graph,
        tickFormat: xAxisLabels,
        element: document.getElementById("survey-line-chart-x")
    } );
    axes.render();
});