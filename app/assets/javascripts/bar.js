
$(function(){
    var seriesData = [[]];
    var random = new Rickshaw.Fixtures.RandomData(150);
   /**
    var myArrayString = $("#bar-responses").text();
    myArrayString = myArrayString.trim();
    var myArray = myArrayString.split(",");
    console.log(myArray);
    for (var k = 0; k < myArray.length; k++){
        myArray[k].replace("")
        var myString = myArray[k].replace("{"," ");
        myString = myArray[k].replace("}"," ");
        myString = myArray[k].replace("["," ");
        myString = myArray[k].replace("["," ");
        var myStringArray = myString.split("=>");
        console.log(myStringArray);
        seriesData[0].push({x: k, y: parseInt(myStringArray[1]) });
    }
       **/
    for (var i = 0; i < 10; i++) {
        random.addData(seriesData);
    }

    var graph = new Rickshaw.Graph( {
        element: document.getElementById("sources-chart-bar"),
        height: 300,
        renderer: 'bar',
        series: [
            {
                color: "blue",
                data: seriesData[0]
            }
        ]
    } );

    graph.render();

    graph.xAxis
        .showMaxMin(false)
        .tickFormat(function(d) { return d3.time.format('%b %d')(new Date(d)) });

});