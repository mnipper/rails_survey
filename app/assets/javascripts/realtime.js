$(function(){

    var numDataPoints = 150;
    var myCount = $("#num-responses").text();
    myCount = parseInt(myCount);
    var seriesData = [];

    for(var k = 0; k < numDataPoints; k++) {
        var timeBase = Math.floor(new Date().getTime() / 1000);
        var data = {};
        data = {x: k + timeBase, y:myCount};
        seriesData[k] = data;
    }

    function populateData() {
        var newSeriesData = [];
        for (var i = 0; i < numDataPoints - 1; i++){
            newSeriesData[i] = seriesData[i + 1];
        }
        var num = $("#num-responses").text();
        //console.log (parseInt(num));
        var timeBase = Math.floor(new Date().getTime() / 1000);
        //newSeriesData[numDataPoints - 1] = {x: numDataPoints + timeBase, y: parseInt(num)};
        seriesData.push({x: numDataPoints + timeBase, y: parseInt(num)});
       // return newSeriesData;
    }

    var palette = new Rickshaw.Color.Palette( { scheme: 'classic9' } );

    var graph = new Rickshaw.Graph( {
        element: document.getElementById("realtime-chart"),
        height: 300,
        renderer: 'area',
        stroke: true,
        preserve: true,
        series: [{
            color: $blue,
            data: seriesData,
            name: 'Responses'
        } ]
    } );

    graph.render();

    $(window).resize(function(){
        graph.width = $("#chart-container").width();
        graph.render();
    });

    var hoverDetail = new Rickshaw.Graph.HoverDetail( {
        graph: graph
    } );

    var annotator = new Rickshaw.Graph.Annotate( {
        graph: graph,
        element: document.getElementById('timeline')
    } );

    var legend = new Rickshaw.Graph.Legend( {
        graph: graph,
        element: document.getElementById('legend')

    } );

    var shelving = new Rickshaw.Graph.Behavior.Series.Toggle( {
        graph: graph,
        legend: legend
    } );

    var order = new Rickshaw.Graph.Behavior.Series.Order( {
        graph: graph,
        legend: legend
    } );

    var highlighter = new Rickshaw.Graph.Behavior.Series.Highlight( {
        graph: graph,
        legend: legend
    } );

    var ticksTreatment = 'glow';

    var xAxis = new Rickshaw.Graph.Axis.Time( {
        graph: graph,
        ticksTreatment: ticksTreatment
    } );

    xAxis.render();

    var yAxis = new Rickshaw.Graph.Axis.Y( {
        graph: graph,
        tickFormat: Rickshaw.Fixtures.Number.formatKMBT,
        ticksTreatment: ticksTreatment
    } );

    yAxis.render();


// add some data every so often

    var messages = [
        "Changed home page welcome message",
        "Minified JS and CSS",
        "Changed button color from blue to green",
        "Refactored SQL query to use indexed columns",
        "Added additional logging for debugging",
        "Fixed typo",
        "Rewrite conditional logic for clarity",
        "Added documentation for new methods"
    ];

    setInterval( function() {
        //random.addData(seriesData);
        //graph.series.data = populateData();
        populateData();
        graph.update();
        //console.log("updated graph");
    }, 1500 );
/**
    function addAnnotation(force) {
        if (messages.length > 0 && (force || Math.random() >= 0.95)) {
            annotator.add(seriesData[2][seriesData[2].length-1].x, messages.shift());
        }
    }

    addAnnotation(true);
    setTimeout( function() { setInterval( addAnnotation, 3000 ) }, 3000 );
 **/
});