function draw(my_data) {
  var margin = {top: 20, right: 20, bottom: 180, left: 40},
      width = 800 - margin.left - margin.right,
      height = 500 - margin.top - margin.bottom;

  var x = d3.scale.ordinal()
      .domain(my_data.name)
      .range([0,width])
      .rangeRoundBands([0, width], .1);

  var xtick_spacing = width/my_data.name.length;

  var y = d3.scale.linear()
      .range([height, 0])
      .domain([0, d3.max(my_data.n_collaborators)]);
      // .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left")
      .ticks(4);

  var svg = d3.select("#graph1")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)
        .selectAll("text")
            .style("text-anchor", "end")
            .attr("dx", "-.2em")
            .attr("dy", ".55em")
            .attr("transform", "rotate(-50)" );

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", "-2.71em")
        .attr("dx","-9em")
        .style("text-anchor", "end")
        .text("Number of Collaborators");

    svg.selectAll(".bar")
      .data( my_data.n_collaborators )
      .enter().append("rect")
        .attr("class", "bar")
        .attr("x", function(d,i) { return 0.98*i*xtick_spacing+xtick_spacing*0.25; })
        .attr("width", 0.8*x.rangeBand())
        .attr("y", function(d) { return d })
        .attr("height", function(d) { return height - y(d); })
        .attr("transform", function(d, i) { return "translate(0," + (height - (height-y(d))) + ")"; });

}
