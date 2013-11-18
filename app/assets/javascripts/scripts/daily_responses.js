
$(function(){

    var graphSeriesData = [];
    var seriesLabels = [];
    var seriesDays = [];
    var myColors = ['blue', 'yellow', 'green', 'red', 'brown', 'black', 'pink', 'orange'];
    var myDivElements = [];
    var myBarGraphs = [];
    var myXAxisElements = [];
    var myXAxes = [];
    var xAxisLabels;
    var counter;

    makeAjaxCall();

    function makeAjaxCall() {
        console.log("make call");
        $.ajax({
            type:'GET',
            url: '/bars',
            success: function(data) {
                var myData = $("#daily-responses").text();
                var parsedData = parseData(myData);
                var series = constructSeriesData(parsedData);
                if (series == true) {
                    constructGraphs();
                }
            }
        });
    }

    function parseData(data) {
        var html = $("#daily-responses").text();
        var div = document.createElement("div");
        div.innerHTML = html;
        var text = div.textContent || div.innerText || "";
        text = text.trim();
        text = text.replace('}}','');
        text = text.split('},');
        var result = {};
        for (var k=0; k < text.length; k++) {
            var instrumentData = text[k].split('=>{');
            var instrumentName = instrumentData[0].trim();
            var instrumentDayCount = instrumentData[1];
            instrumentName = instrumentName.replace('{','');
            instrumentName = instrumentName.substring(1,instrumentName.length-1);
            instrumentDayCount = instrumentDayCount.split(',');
            var dayCountHash = {};
            for(var i=0; i < instrumentDayCount.length; i++) {
                var dayCounts = instrumentDayCount[i].split('=>');
                var day = dayCounts[0].trim();
                day = day.substring(1,day.length-1);
                dayCountHash[day] = parseInt(dayCounts[1]);
            }
            result[instrumentName] = dayCountHash;
        }

        initializeArrays(result);
        createDivElements(result);

        return result;
    }

    function initializeArrays(myHash) {
        var j = 0;
        var key;
        for (key in myHash) {
            if (myHash.hasOwnProperty(key)) {
                graphSeriesData[j] = [];
                seriesDays[j] = [];
                j++;
            }
        }
    }

    function createDivElements(hash) {
        var k = 0;
        var key;
        for (key in hash) {
            if (hash.hasOwnProperty(key))  {
                var parentDivElement = document.getElementById('survey-bar-counts');
                var newDivElement = document.createElement('div');
                var divIdName = 'survey-bar-counts'+k;
                newDivElement.setAttribute('id',divIdName);
                parentDivElement.appendChild(newDivElement);
                var newXAxisElement = document.createElement('div');
                var xAxisName = 'x-axis'+divIdName;
                newXAxisElement.setAttribute('id',xAxisName);
                parentDivElement.appendChild(newXAxisElement);
                myDivElements[k] = divIdName;
                myXAxisElements[k] = xAxisName;
                k++;
            }
        }
    }

    function constructSeriesData(data) {
        var k = 0;
        for (var key in data) {
            if (data.hasOwnProperty(key))  {
                seriesLabels[k] = key;
                var keyValue = data[key];
                var i = 0;
                for (var day in keyValue) {
                    if (keyValue.hasOwnProperty(day)) {
                        seriesDays[k].push(day.substring(5));
                        graphSeriesData[k].push({x: i, y: keyValue[day]});
                        i++;
                    }
                }
                k++;
            }
        }
        return true;
    }

    function constructGraphs() {

        for (var k = 0; k < myDivElements.length; k++) {
            myBarGraphs[k] = 'barGraph'+k;
        }

        for (var i = 0; i < myBarGraphs.length; i++) {
            myBarGraphs[i] =  new Rickshaw.Graph({
            element: document.getElementById(myDivElements[i]),
            height: 300,
            renderer: 'bar',
            series: [
                {
                    color: myColors[Math.floor(Math.random() * myColors.length)],
                    data: graphSeriesData[i],
                    name: seriesLabels[i]
                }
            ]
        });
        myBarGraphs[i].render();
        }
        drawXaxis();
    }

    xAxisLabels = function (n) {
        var map = { };
        var days = seriesDays[counter];
        console.log(days);
        for (var i = 0; i < days.length; i++) {
            map[i] = days[i];
            console.log(map[i]);
        }
        return map[counter];
    };

    function drawXaxis(){
        for (var k=0; k<myXAxisElements.length; k++) {
           myXAxes[k] = 'xaxis'+k;
        }
        for(var j=0; j<myXAxes.length; j++) {
            counter = j;
            myXAxes[j] = new Rickshaw.Graph.Axis.X({
                graph: myBarGraphs[j],
                element: document.getElementById(myXAxisElements[j]),
                tickFormat: xAxisLabels()
            });
            myXAxes[j].render();
        }
    }
});
