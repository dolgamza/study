<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <style>
        svg circle {
          fill: orange;
          opacity: .5;
          stroke: white;
        }
        svg circle:hover {
          fill: red;
          stroke: #333;
        }
        svg text {
          pointer-events: none;
        }
        svg .municipality {
          fill: #efefef;
          stroke: #fff;
        }
        svg .municipality-label {
          fill: #bbb;
          font-size: 12px;
          font-weight: 300;
          text-anchor: middle;
        }
        svg #map text {
          color: #333;
          font-size: 10px;
          text-anchor: middle;
        }
        svg #places text {
          color: #777;
          font: 10px sans-serif;
          text-anchor: start;
        }
        #title {
            font-family: sans-serif;
        }
        #title p {
            font-size: 10pt;
        }
    </style>
  </head>
  <body>
    <script src="http://d3js.org/d3.v3.min.js"></script>
    <script src="http://d3js.org/topojson.v1.min.js"></script>
    <script>
    var width = 800,
        height = 600;
    var svg = d3.select("#chart").append("svg")
        .attr("width", width)
        .attr("height", height);
    var map = svg.append("g").attr("id", "map"),
        places = svg.append("g").attr("id", "places");
    var projection = d3.geo.mercator()
        .center([126.9895, 37.5651])
        .scale(100000)
        .translate([width/2, height/2]);
    var path = d3.geo.path().projection(projection);
    d3.json("map_all.json", function(error, data) {
      var features = topojson.feature(data, data.objects.seoul_municipalities_geo).features;
      map.selectAll('path')
          .data(features)
        .enter().append('path')
          .attr('class', function(d) { console.log(); return 'municipality c' + d.properties.code })
          .attr('d', path);
      map.selectAll('text')
          .data(features)
        .enter().append("text")
          .attr("transform", function(d) { return "translate(" + path.centroid(d) + ")"; })
          .attr("dy", ".35em")
          .attr("class", "municipality-label")
          .text(function(d) { return d.properties.name; })
    });
    d3.csv("beable.csv", function(data) {
        places.selectAll("circle")
            .data(data)
          .enter().append("circle")
            .attr("cx", function(d) { return projection([d.lon, d.lat])[0]; })
            .attr("cy", function(d) { return projection([d.lon, d.lat])[1]; })
            .attr("r", 10);
        places.selectAll("text")
            .data(data)
          .enter().append("text")
            .attr("x", function(d) { return projection([d.lon, d.lat])[0]; })
            .attr("y", function(d) { return projection([d.lon, d.lat])[1] + 8; })
            .text(function(d) { return d.name });
    });
    </script>
  </body>
</html>