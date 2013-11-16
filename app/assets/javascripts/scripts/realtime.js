
$(function(){
    var numberOfDataPoints = 150;
    var seriesData = [[], [], [], [], [], [], [], [], [], [], [], []];
    var realtimeGraph;
    var instrumentNames = [];
    var myColors = ['blue', 'yellow', 'green', 'red', 'brown', 'black', 'pink', 'orange'];

    makeAjaxCall();

    function parseData(data) {
        var myData = data.split('[');
        myData = myData[1].split(']');
        myData = myData[0].split(',');
        var parsedDataArray = [];
        for (var i = 0; i < myData.length; i++) {
            var nameAndCount = myData[i];
            nameAndCount = nameAndCount.replace('&quot;','');
            nameAndCount = nameAndCount.replace('&quot;','');
            nameAndCount = nameAndCount.split('=&gt;');
            var name = nameAndCount[0].replace('{','');
            var count = nameAndCount[1].replace('}','');
            var innerArray = [name, count];
            parsedDataArray.push(innerArray);
        }
        return parsedDataArray;
    }

    function makeAjaxCall() {
        $.ajax({
            type:'GET',
            url: '/realtime',
            success: function(data) {
                var myData = parseData(data);
                constructSeriesData(myData);
            }
        });
    }

    function rePopulateData() {
        $.ajax({
            type:'GET',
            url: '/realtime',
            success: function(data) {
                var myData = parseData(data);

                for(var k = 0; k < myData.length; k++) {
                    var array = myData[k];
                    var timeBase = Math.floor(new Date().getTime() / 1000);
                    seriesData[k].push({ x : timeBase + k, y : parseInt(array[1]) });
                }
                realtimeGraph.update();
                //console.log("updated");
            }
        });
    }

    function constructSeriesData(sourceData) {

        for (var i = 0; i < sourceData.length; i++) {
            var arr = sourceData[i];
            var subSeriesData = [];
            for(var k = 0; k < numberOfDataPoints; k++) {
                var timeBase = Math.floor(new Date().getTime() / 1000);
                var data = {};
                data = {x: k + timeBase, y: parseInt(arr[1])};
                subSeriesData[k] = data;
            }
            seriesData[i] = subSeriesData;
            instrumentNames[i] = arr[0];
        }
        drawGraph();
    }

    function drawGraph() {

        var palette = new Rickshaw.Color.Palette( { scheme: 'classic9' } );
        //var elem = document.getElementById("survey-realtime-chart");
        //console.log(elem);

        try {
            realtimeGraph = new Rickshaw.Graph({
                element: document.getElementById("survey-realtime-chart"),
                height: 300,
                renderer: 'line',
                stroke: true,
                preserve: true,
                series: dynamicSeries()
            });
            realtimeGraph.render();
        }
        catch (err) {

        }

        function dynamicSeries() {
            var myArray = [];
            for (var k = 0; k < instrumentNames.length; k++) {
                myArray[k] = {
                    color: myColors[Math.floor(Math.random() * myColors.length)],
                    data: seriesData[k],
                    name: instrumentNames[k]
                };
            }
            return myArray;
        }

        $(window).resize(function(){
            realtimeGraph.width = $("#chart-container").width();
            realtimeGraph.render();
        });

        var hoverDetail = new Rickshaw.Graph.HoverDetail( {
            graph: realtimeGraph
        } );

        var annotator = new Rickshaw.Graph.Annotate( {
            graph: realtimeGraph,
            element: document.getElementById('timeline')
        } );

        var legend = new Rickshaw.Graph.Legend( {
            graph: realtimeGraph,
            element: document.getElementById('legend')

        } );

        var shelving = new Rickshaw.Graph.Behavior.Series.Toggle( {
            graph: realtimeGraph,
            legend: legend
        } );

        var order = new Rickshaw.Graph.Behavior.Series.Order( {
            graph: realtimeGraph,
            legend: legend
        } );

        var highlighter = new Rickshaw.Graph.Behavior.Series.Highlight( {
            graph: realtimeGraph,
            legend: legend
        } );

        var ticksTreatment = 'glow';

        var xAxis = new Rickshaw.Graph.Axis.Time( {
            graph: realtimeGraph,
            ticksTreatment: ticksTreatment
        } );

        xAxis.render();

        var yAxis = new Rickshaw.Graph.Axis.Y( {
            graph: realtimeGraph,
            tickFormat: Rickshaw.Fixtures.Number.formatKMBT,
            ticksTreatment: ticksTreatment
        } );

        yAxis.render();


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
            rePopulateData();
        }, 30000 );


        function addAnnotation(force) {
            if (messages.length > 0 && (force || Math.random() >= 0.95)) {
                annotator.add(seriesData[2][seriesData[2].length-1].x, messages.shift());
            }
        }

        addAnnotation(true);
        setTimeout( function() { setInterval( addAnnotation, 3000 ) }, 3000 );

    }

});