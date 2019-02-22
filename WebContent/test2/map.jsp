<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<meta charset="utf-8">
<style>
body { background-color: #1A1A1A; }

path {
  stroke-linejoin: round;
}

.land {
  fill: #4C4C4C;
}

.states {
  fill: none;
  stroke: darkgray;
}

svg .municipality-label {
  fill: #D5D5D5;
  font-size: 11px;
  font-weight: 300;
  text-anchor: middle;
  font-family: monospace;
}
</style>
<body>
<script src="//d3js.org/d3.v3.min.js"></script>
<script src="//d3js.org/queue.v1.min.js"></script>
<script src="//d3js.org/topojson.v1.min.js"></script>
<script>
//var color = d3.scale.category20();
var width = 1000,
    height = 1400;
var centered;
var projection = d3.geo.mercator()
    .center([126.9895, 37.5651])
    .scale(65000)
    ;
 
var path = d3.geo.path().projection(projection);

var svg = d3.select("body").append("svg")
    .attr("width", width)
    .attr("height", height);

var g = svg.append("g");

svg.append("rect")
    .attr("class", "background")
    .attr("width", width)
    .attr("height", height)
    .style("fill", "none")
    .on("click", clicked);

var tooltip = d3.select("body")
  .append("div")
  .style("position", "absolute")
  .style("z-index", "10")
  .style("visibility", "hidden")
  .style("font-family", "sans-serif")
  .style("color", "#FF5E00")
  .style("font-size", "15px");

queue()
	.defer(d3.json, "map_test.json")
    .defer(d3.csv, "beable.csv")
    .await(ready);
 
function ready(error, kor, stations) {
  if (error) throw error;
  var features = topojson.feature(kor, kor.objects.map_test).features;
  g.selectAll("path")
        .data(features)
        .enter().append("path")
        .attr("class", "land")
        .attr("d", path)
        .attr("id", function(d) { return d.properties.SIG_KOR_NM; })
        .on("click", clicked)
        .append("title");

  g.append("path")
      .datum(topojson.mesh(kor, kor.objects.map_test, function(a, b) { return a !== b; }))
      .attr("class", "states")
      .attr("d", path);

  g.selectAll('text')
      .data(features)
      .enter().append("text")
      .attr("transform", function(d) { return "translate(" + path.centroid(d) + ")"; })
      .attr("dy", ".50em")
      .attr("class", "municipality-label")
      .text(function(d) { return d.properties.SIG_KOR_NM; })
  
  g.selectAll("circle")
      .data(stations)
      .enter().append("circle")
      .attr("cx", function(d) { return projection([d.lon, d.lat])[0]; })
      .attr("cy", function(d) { return projection([d.lon, d.lat])[1]; })
      .attr("r", 5)
      .attr("opacity", 0.9)
      //.attr("fill", function(d){ return color(d.gubun);})
      .attr("fill", "darkblue")
      .on("mouseover", function(d){
        tooltip.style("visibility", "visible")
        .text(d.name);
      })
      .on("mousemove", function(){
        tooltip.style("top", (event.pageY-10)+"px").style("left",(event.pageX+10)+"px");
      })
      .on("mouseout", function(){
        tooltip.style("visibility", "hidden");
      });

}

function clicked(d) {
  var x, y, k;

  if (d && centered !== d) {
    var centroid = path.centroid(d);
    x = centroid[0];
    y = centroid[1];
    k = 3;
    centered = d;
  } else {
    x = width / 2;
    y = height / 2;
    k = 1;
    centered = null;
  }

  g.selectAll("path")
      .classed("active", centered && function(d) { return d === centered; });

  g.transition()
      .duration(750)
      .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")scale(" + k + ")translate(" + -x + "," + -y + ")")
      .style("stroke-width", 1.5 / k + "px");
}
</script>