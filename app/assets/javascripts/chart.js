

$(document).on("turbolinks:load", function(){
    // BEGIN CHART 1
    $.get('/chart/index_panel_one_data.json', function(data){

        var margin = {left:75, right:25, bottom:50, top:50}; //position the graph within the svg using these values
        var width = 500 - margin.left - margin.right; //defines the width of the visualization
        var height = 650 - margin.top - margin.bottom; //defines the height of the visualization

        var keys = Object.keys(data);
        //var values = "REMOVED";

        var g = d3.select('#chart1')
            .append('svg')
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")"); // translate moves the x,y coordinates by the values supplied as arguments

        var x = d3.scaleBand()
            .domain(keys)
            .range([0,width])
            .paddingInner(0.2)
            .paddingOuter(0.2);

        // var maxValue = d3.max(values, function(v) { return v });

        var y = d3.scaleLinear()
            .domain([0, 1])
            .range([height,0]);

        var bars = g.selectAll("rect")
            .data(keys);

        bars.enter()
            .append("rect")
            .attr("x", function(d,i) { return x(d); })
            .attr("y", function(d,i) { return y(data[d]) })
            .attr("height",function(d,i) { return height - y(data[d]) })
            .attr("width", x.bandwidth)
            .attr("fill", "blue");

        var xAxisCall = d3.axisBottom(x);
        g.append("g")
            .attr("class", "x-axis")
            .attr("transform", "translate(0,"+ height + ")")
            .call(xAxisCall);

        var yAxisCall = d3.axisLeft(y);
        g.append("g")
            .attr("class", "y-axis")
            .call(yAxisCall);

        // x axis label

        g.append("text")
            .attr("class", "x-axis-label")
            .attr("x", width / 2)
            .attr("y", height + 40)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .text("Diagnosis")

        // y axis label

        g.append("text")
            .attr("class", "y-axis-label")
            .attr("x", - (height / 2))
            .attr("y",-70)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .attr("transform", "rotate(-90)")
            .text("Samples Received by UCSF")


    }); // closes jquery get call
    // END CHART 1

    // BEGIN CHART 2
    $.get('/chart/index_panel_two_data.json', function(data) {

        var margin = {left:100, right:25, bottom:50, top:50}; //position the graph within the svg using these values
        var width = 500 - margin.left - margin.right; //defines the width of the visualization
        var height = 500 - margin.top - margin.bottom; //defines the height of the visualization

        var g = d3.select('#chart2')
            .append('svg')
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")"); // translate moves the x,y coordinates by the values supplied as arguments
        var stack = d3.stack()
            .keys(['HLA_genotypes_available', 'samples_sent_to_sequencing_lab']);
        var series = stack(data);

        var x = d3.scaleBand()
            .domain(data.map(function(d) { return d.diagnosis }))
            .range([0,width])
            .paddingInner(0.3)
            .paddingOuter(0.2)

        var y = d3.scaleLinear()
            .domain([0, d3.max(data, function(d) { return d.HLA_genotypes_available + d.samples_sent_to_sequencing_lab })])
            .range([height - 75 ,0]);

        var color = d3.scaleOrdinal()
            .domain(data.map(function(d) { return d.key }))
            .range(["#A5A3FF", "#2B46E2"]);

        g.append("g")
            .selectAll("g")
            .data(series)
            .enter().append("g")
            .attr("fill", function(d) {
                return color(d.key)
            })
            .selectAll("rect")
            .data(function(d) {
                return d;
            })
            .enter().append("rect")
            .attr("x", function(d) {
                return x(d.data.diagnosis)
            })
            .attr("y", function(d) {
                return y(d[1]) + 75
            })
            .attr("height", function(d) {
                return y(d[0]) - y(d[1]);
            })
            .attr("width", x.bandwidth())
            .on("mouseover", function() { tooltip.style("display", null); })
            .on("mouseout", function() { tooltip.style("display", "none"); })
            .on("mousemove", function(d) {
                var xPosition = d3.mouse(this)[0] - 30;
                var yPosition = d3.mouse(this)[1] - 45;
                tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
                tooltip.select("text").text((d[1] - d[0]));
            });

        var xAxisCall = d3.axisBottom(x);
        g.append("g")
            .attr("class", "x-axis")
            .attr("transform", "translate(0,"+ height + ")")
            .call(xAxisCall)
            .selectAll("text")
            .attr("font-size", "14px")

        var yAxisCall = d3.axisLeft(y);
        g.append("g")
            .attr("class", "y-axis")
            .attr("transform", "translate(0,75)")
            .call(yAxisCall)
            .selectAll("text")
            .attr("font-size", "14px")

        // x axis label

        g.append("text")
            .attr("class", "x-axis-label")
            .attr("x", width / 2)
            .attr("y", height + 40)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .text("Diagnosis")

        // y axis label

        g.append("text")
            .attr("class", "y-axis-label")
            .attr("x", - ((height / 2) + 30))
            .attr("y",-70)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .attr("transform", "rotate(-90)")
            .text("Samples Received by UCSF")

        // legend

        var legend = g.append("g")
            .attr("font-size", "12px")
            .attr("text-anchor", "start")
            .selectAll("g")
            .data(series.reverse())
            .enter().append("g")
            .attr("transform", function(d, i) {
                return "translate("+ -325 + ","+ (i * 25) + ")";
            });
        legend.append("rect")
            .attr("x", width - 50)
            .attr("width", 19)
            .attr("height", 19)
            .attr("fill", function(d) {
                return color(d.key)
            });

        legend.append("text")
            .attr("x", width - 24)
            .attr("y", 15)
            .text(function(d) {
                var str = d.key.split("_").join(" ");
                return str
            })
            .attr("font-size", "14px");

        g.append("text")
            .attr("class", "chart2-title")
            .attr("x", width / 2)
            .attr("y", -20)
            .attr("font-size", "20px")
            .attr("text-anchor", "middle")
            .text("HLA processing");


        var tooltip = g.append("g")
            .attr("class", "graph-tooltip")
            .style("display", "none");

        tooltip.append("rect")
            .attr("width", 45)
            .attr("height", 30)
            .attr("fill", "black");

        tooltip.append("text")
            .attr("x", 22.5)
            .attr("dy", "1.2em")
            .style("text-anchor", "middle")
            .attr("font-size", "16px")
            .attr("font-weight", "bold")
            .attr("fill", 'white');

    }); // closes jquery get call
    // END CHART 2

    // BEGIN CHART 3
    $.get('/chart/index_panel_three_data.json', function(data) {

        var margin = {left:100, right:25, bottom:50, top:50}; //position the graph within the svg using these values
        var width = 500 - margin.left - margin.right; //defines the width of the visualization
        var height = 500 - margin.top - margin.bottom; //defines the height of the visualization

        var g = d3.select('#chart3')
            .append('svg')
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")"); // translate moves the x,y coordinates by the values supplied as arguments
        var stack = d3.stack()
            .keys(['KIR_genotypes_available', 'KIR_raw_sequences_to_be_genotyped', 'samples_sent_to_sequencing_lab']);
        var series = stack(data);

        var x = d3.scaleBand()
            .domain(data.map(function(d) { return d.diagnosis }))
            .range([0,width])
            .paddingInner(0.3)
            .paddingOuter(0.2)

        var y = d3.scaleLinear()
            .domain([0, d3.max(data, function(d) { return d.KIR_genotypes_available + d.KIR_raw_sequences_to_be_genotyped + d.samples_sent_to_sequencing_lab })])
            .range([height - 75 ,0])

        var color = d3.scaleOrdinal()
            .domain(data.map(function(d) { return d.key }))
            .range(["#A5A3FF","#2B46E2", "#7F7DFF"]);

        g.append("g")
            .selectAll("g")
            .data(series)
            .enter().append("g")
            .attr("fill", function(d) {
                return color(d.key)
            })
            .selectAll("rect")
            .data(function(d) {
                return d;
            })
            .enter().append("rect")
            .attr("x", function(d) {
                return x(d.data.diagnosis)
            })
            .attr("y", function(d) {
                return y(d[1]) + 75
            })
            .attr("height", function(d) {
                return y(d[0]) - y(d[1]);
            })
            .attr("width", x.bandwidth())
            .on("mouseover", function() { tooltip.style("display", null); })
            .on("mouseout", function() { tooltip.style("display", "none"); })
            .on("mousemove", function(d) {
                var xPosition = d3.mouse(this)[0] - 30;
                var yPosition = d3.mouse(this)[1] - 45;
                tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
                tooltip.select("text").text((d[1] - d[0]));
            });

        var xAxisCall = d3.axisBottom(x);
        g.append("g")
            .attr("class", "x-axis")
            .attr("transform", "translate(0,"+ height + ")")
            .call(xAxisCall)
            .selectAll("text")
            .attr("font-size", "14px")

        var yAxisCall = d3.axisLeft(y);
        g.append("g")
            .attr("class", "y-axis")
            .attr("transform", "translate(0,75)")
            .call(yAxisCall)
            .selectAll("text")
            .attr("font-size", "14px")

        // x axis label

        g.append("text")
            .attr("class", "x-axis-label")
            .attr("x", width / 2)
            .attr("y", height + 40)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .text("Diagnosis")

        // y axis label

        g.append("text")
            .attr("class", "y-axis-label")
            .attr("x", - ((height / 2) + 30))
            .attr("y",-70)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .attr("transform", "rotate(-90)")
            .text("Samples Received by UCSF")

        // legend

        var legend = g.append("g")
            .attr("font-size", "12px")
            .attr("text-anchor", "start")
            .selectAll("g")
            .data(series.reverse())
            .enter().append("g")
            .attr("transform", function(d, i) {
                return "translate("+ -325 + ","+ (i * 22) + ")";
            });
        legend.append("rect")
            .attr("x", width - 50)
            .attr("width", 19)
            .attr("height", 19)
            .attr("fill", function(d) {
                return color(d.key)
            });

        legend.append("text")
            .attr("x", width - 24)
            .attr("y", 15)
            .text(function(d) {
                var str = d.key.split("_").join(" ");
                return str
            })
            .attr("font-size", "14px");;

        g.append("text")
            .attr("class", "chart2-title")
            .attr("x", width / 2)
            .attr("y", -20)
            .attr("font-size", "20px")
            .attr("text-anchor", "middle")
            .text("KIR processing");

        var tooltip = g.append("g")
            .attr("class", "graph-tooltip")
            .style("display", "none");

        tooltip.append("rect")
            .attr("width", 45)
            .attr("height", 30)
            .attr("fill", "black");

        tooltip.append("text")
            .attr("x", 22.5)
            .attr("dy", "1.2em")
            .style("text-anchor", "middle")
            .attr("font-size", "16px")
            .attr("font-weight", "bold")
            .attr("fill", 'white');

    }); // closes jquery get call
    // END CHART 3

    // BEGIN CHART 4

    $.get('/chart/index_panel_four_data.json', function(data) {
        console.log(data);

        var margin = {left:170, right:25, bottom:50, top:50}; //position the graph within the svg using these values
        var width = 1000 - margin.left - margin.right; //defines the width of the visualization
        var height = 450 - margin.top - margin.bottom; //defines the height of the visualization

        var keys = Object.keys(data);
        var values = keys.map(function(k) { return data[k]; });

        var g = d3.select('#chart4')
            .append('svg')
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")"); // translate moves the x,y coordinates by the values supplied as arguments

        var x = d3.scaleBand()
            .domain(keys)
            .range([0,width])
            .paddingInner(0.1)
            .paddingOuter(0.2);

        var maxValue = d3.max(values, function(v) { return v });

        var y = d3.scaleLinear()
            .domain([0, maxValue])
            .range([height,0]);

        var bars = g.selectAll("rect")
            .data(keys);

        bars.enter()
            .append("rect")
            .attr("x", function(d,i) { return x(d); })
            .attr("y", function(d,i) { return y(data[d]) })
            .attr("height",function(d,i) { return height - y(data[d]) })
            .attr("width", x.bandwidth)
            .attr("fill", "#2B46E2");

        var xAxisCall = d3.axisBottom(x);
        g.append("g")
            .attr("class", "x-axis")
            .attr("transform", "translate(0,"+ height + ")")
            .call(xAxisCall)
            .selectAll("text")
            .attr("font-size", "10pt");

        var yAxisCall = d3.axisLeft(y);
        g.append("g")
            .attr("class", "y-axis")
            .call(yAxisCall)
            .selectAll("text")
            .attr("font-size", "10pt");

        // x axis label

        g.append("text")
            .attr("class", "x-axis-label")
            .attr("x", width / 2)
            .attr("y", height + 40)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .text("KIR Locus");

        // y axis label

        g.append("text")
            .attr("class", "y-axis-label")
            .attr("x", - (height / 2))
            .attr("y",-70)
            .attr("font-size", "16px")
            .attr("text-anchor", "middle")
            .attr("transform", "rotate(-90)")
            .text("Samples with KIR locus genotyped")
    }); // closes jquery get call
    // END CHART 4

});




