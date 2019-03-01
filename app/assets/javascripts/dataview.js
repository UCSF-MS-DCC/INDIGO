// // # Place all the behaviors and hooks related to the matching controller here.
// // # All this logic will automatically be available in application.js.
// // # You can use CoffeeScript in this file: http://coffeescript.org/
function capitalize(str) {
    arr = str.split(" ")
    arr.forEach(function(s, idx) {
        s = s.split("")
        s[0] = s[0].toUpperCase();
        arr[idx] = s.join("")
    });
    return arr.join(" ")
}
function removeSpace(str) {
    newStr = str.split(' ').join("");
    return newStr;
}
$(document).on("turbolinks:load", function() {

  var superindex_disease = $('#disease-selector').text();

  var stacy_table = $('#stacy-samples-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":'/dataview/sample_status.json',
    "pagingType":"full_numbers",
    "columns": [
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        console.log(row)
          if (data) {
            return '<a href='+row[12]+'>'+data+'</a>';
          }
          else {
            return '-';
          }
      }}
    ],
    "paging":true,
    "lengthMenu":[10,25,50,100,250,1000]
  });

  var samples_index_table = $('#samples-index-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":'/dataview/samples_index.json',
    "pagingType":"full_numbers",
    "columns": [
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        return data;
      }},
      {"render": function(data, type, row, meta) {
        console.log(row)
          if (data) {
            return '<a href='+row[11]+'>'+data+'</a>';
          }
          else {
            return '-';
          }
      }}
    ],
    "paging":true,
    "lengthMenu":[10,25,50,100,250,500,1000,2500,5000,10000],
      "dom": "<'row'<'col-sm-2'l><'col-sm-2 col-sm-offset-8'f>>"+"<'row'<'col-sm-4 col-sm-offset-5'B>>" + "<'row'<'col-sm-12'rtip>>",
      "buttons": [
          {
              "extend":'csv',
              "text": '<i>Download CSV</i>',
              "className": 'btn btn-indigo btn-sm',
              "exportOptions": {
                  "columns": [0, ':visible']
              }
          }
      ]
  });
//var d = "Blfrtip" <- jquery datatables dom element list
  var hlas_index_table = $('#hlas-index-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":'/dataview/hla_index.json',
    "pagingType":"full_numbers",
    "paging":true,
      "lengthMenu":[10,25,50,100,250,500,1000,2500,5000,10000],
      "dom": "<'row'<'col-sm-2'l><'col-sm-2 col-sm-offset-8'f>>" + "<'row'<'col-sm-4 col-sm-offset-5'B>>" + "<'row'<'col-sm-12'rtip>>",
      "buttons": [
          {
              "extend":'csv',
              "text": '<i>Download CSV</i>',
              "className": 'btn btn-indigo btn-sm',
              "exportOptions": {
                  "columns": [0, ':visible']
              }
          }
      ]
  });

  var kirs_index_table = $('#kirs-index-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":'/dataview/kir_index.json',
    "pagingType":"full_numbers",
    "paging":true,
      "lengthMenu":[10,25,50,100,250,500,1000,2500,5000,10000],
      "dom": "<'row'<'col-sm-2'l><'col-sm-2 col-sm-offset-8'f>>" + "<'row'<'col-sm-4 col-sm-offset-5'B>>" + "<'row'<'col-sm-12'rtip>>",
      "buttons": [
          {
              "extend":'csv',
              "text": '<i>Download CSV</i>',
              "className": 'btn btn-indigo btn-sm',
              "exportOptions": {
                  "columns": [0, ':visible']
              }
          }
      ]
  });

  var samples_superindex_table = $('#samples-superindex-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":{"url":'/dataview/samples_superindex.json', "data": function(d) { d.disease = superindex_disease } },
    "pagingType":"full_numbers",
    "paging":true,
    "lengthMenu":[10,25,50,100,250,500,1000,2500,5000,10000],
      "dom": "<'row'<'col-sm-2'l><'col-sm-2 col-sm-offset-8'f>>" + "<'row'<'col-sm-1'B>>" + "<'row'<'col-sm-12'rtip>>",
      "buttons": [
          {
              "extend":'csv',
              "text": '<i>Download CSV</i>',
              "className": 'btn btn-indigo btn-sm',
              "exportOptions": {
                  "columns": [0, ':visible']
              }
          }
      ]
  });

  var hlas_superindex_table = $('#hlas-superindex-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":{"url":'/dataview/hla_superindex.json', "data": function(d) { d.disease = superindex_disease } },
    "pagingType":"full_numbers",
    "paging":true,
      "lengthMenu":[10,25,50,100,250,500,1000,2500,5000,10000],
      "dom": "<'row'<'col-sm-2'l><'col-sm-2 col-sm-offset-8'f>>" + "<'row'<'col-sm-1'B>>" + "<'row'<'col-sm-12'rtip>>",
      "buttons": [
          {
              "extend":'csv',
              "text": '<i>Download CSV</i>',
              "className": 'btn btn-indigo btn-sm',
              "exportOptions": {
                  "columns": [0, ':visible']
              }
          }
      ]
  });

  var kirs_superindex_table = $('#kirs-superindex-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "ajax":{"url":'/dataview/kir_superindex.json', "data": function(d) { d.disease = superindex_disease } },
    "pagingType":"full_numbers",
    "paging":true,
      "lengthMenu":[10,25,50,100,250,500,1000,2500,5000,10000],
      "dom": "<'row'<'col-sm-2'l><'col-sm-2 col-sm-offset-8'f>>" + "<'row'<'col-sm-1'B>>" + "<'row'<'col-sm-12'rtip>>",
      "buttons": [
          {
              "extend":'csv',
              "text": '<i>Download CSV</i>',
              "className": 'btn btn-indigo btn-sm',
              "exportOptions": {
                  "columns": [0, ':visible']
              }
          }
      ]
  });

  var kir_work_in_progress_table = $('#kir-work-in-progress-table').DataTable({
      "autoWidth":false,
      "pageLength":100,
      "bServerSide":true,
      "bProcessing":true,
      "bPaginate":true,
      "ajax":'/dataview/kir_wip_data.json',
      "pagingType":"full_numbers",
      "columns": [
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  if (data) {
                      return '<a href="/dataview/single_kir_genotype_version_table?indigo_id='+row[0]+'&locus='+row[1]+'">'+data+'</a>';
                  } else {
                      return "N/A"
                  }
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }},
          {"render": function(data, type, row, meta) {
                  return data;
              }}
      ],
      "paging":true,
      "lengthMenu":[10,25,50,100,250,1000]
  });
    var single_wip_version_indigo_id = $('#sample-indigo-id').text();
    var single_wip_version_locus = $('#sample-locus').text();
    var single_kir_work_in_progress_version_table = $('#single-kir-work-in-progress-version-table').DataTable({
        "autoWidth":false,
        "pageLength":100,
        "bServerSide":true,
        "bProcessing":true,
        "bPaginate":true,
        "ajax": { "url":'/dataview/single_kir_wip_versions_data.json', "data": function(d) { d.indigo_id = single_wip_version_indigo_id, d.locus = single_wip_version_locus} },
        "pagingType":"full_numbers",
        "columns": [
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }}
        ],
        "paging":true,
        "lengthMenu":[10,25,50,100,250,1000]
    });
  var method_version = $('#version-date').text();

    var kir_method_version_table = $('#kir-method-version-table').DataTable({
        "autoWidth":false,
        "pageLength":100,
        "bServerSide":true,
        "bProcessing":true,
        "bPaginate":true,
        "ajax":{"url":'/dataview/method_version_data.json', "data": function(d) { d.method_version = method_version } },
        "pagingType":"full_numbers",
        "columns": [
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }},
            {"render": function(data, type, row, meta) {
                    return data;
                }}
        ],
        "paging":true,
        "lengthMenu":[10,25,50,100,250,1000]
    });

    var allele_frequencies_table = $('#allele-frequencies-table').DataTable({
        "autoWidth":false,
        "pageLength":100,
        "bServerSide":true,
        "bProcessing":true,
        "bPaginate":true,
        "ajax":'/dataview/allele_frequencies_data.json',
        "pagingType":"full_numbers",
        "paging":false,
        "lengthMenu":[10,25,50,100,250,1000],
        "scrollX":true,
        "scrollCollapse":true,
        "fixedColumns":{
            "leftColumns":3,
            "rightColumns":0
        }
    });

    var haplotype_frequencies_table = $('#haplotype-frequencies-table').DataTable({
        "autoWidth":false,
        "pageLength":100,
        "bServerSide":true,
        "bProcessing":true,
        "bPaginate":true,
        "ajax":{"url":'/dataview/haplotype_frequencies_data.json', "data": function(d) { d.disease = superindex_disease } },
        "pagingType":"full_numbers",
        "paging":false,
        "lengthMenu":[10,25,50,100,250,1000],
        "scrollX":true,
        "scrollCollapse":true,
        "fixedColumns":{
            "leftColumns":3,
            "rightColumns":0
        }
    });

  var tables = {
    "samples-index-table":samples_index_table,
    "hlas-index-table":hlas_index_table,
    "kirs-index-table":kirs_index_table,
    "samples-superindex-table":samples_superindex_table,
    "hlas-superindex-table":hlas_superindex_table,
    "kirs-superindex-table":kirs_superindex_table
  };


  $('.show-column-checkbox').on('change', function(){
    var table = tables[$(this).data("table-id")];
    var col = $(this).data("column");
    var checked = $(this).prop("checked");
    var isMultiCol = new RegExp(",");
    if (isMultiCol.test(col)) {
        var cols = col.split(",");
        cols.forEach(function(c) {
            table.columns(c).visible(checked);
        })
    } else {
        table.columns(col).visible(checked);
    }

  });

  if(window.location.pathname == '/dataview/superindex') {
      $.get('/dataview/superindex_race_graph.json'+'?disease[]='+superindex_disease, function(data) {
          console.log("DATA:", data);
          var margin = {left:0, right:25, top:0, bottom:25};
          var width = 475 - margin.left - margin.right;
          var height = 350 - margin.top - margin.bottom;

          var g = d3.select("#race-graph")
              //.attr("style","border: 1px solid red")
              .append("svg")
              .attr("width", width)
              .attr("height", height)
              //.attr("style", "border:1px solid green")
              .attr("transform", "translate(" + (margin.left) + "," + (margin.top) + ")")
              .append("g")
              .attr("transform", "translate(" + 150 +",50)");


          var x = d3.scaleLinear()
              .domain([0, d3.max(data, function(d) { return d.samples })])
              .range([0, width/2 + 50]);

          var y = d3.scaleBand()
              .domain(data.map(function(d) { return d.race }))
              .range([0,height - 100])
              .paddingInner(1.0)
              .paddingOuter(0.3)

          var groups = g.append("g")
              .selectAll("g")
              .data(data)
              .enter().append("g")


          groups.selectAll("line")
              .data(data)
              .enter().append("line")
              .attr("x1", 0)
              .attr("x2", function(d) { return +x(d.samples) })
              .attr("y1", function(d, i) {  return y(d.race) })
              .attr("y2", function(d, i) { return +(y(d.race)) })
              .style("stroke", "black")
              .style("stroke-width", "1")
              .style("stroke-dasharray", "3,6")


          groups.selectAll("circle")
              .data(data)
              .enter().append("circle")
              .attr("r", 5)
              .attr("fill", 'black')
              .attr("cx", function(d) { return +x(d.samples) - 4 })
              .attr("cy", function(d) { return +(y(d.race)) })


          var xAxisCall = d3.axisBottom(x).ticks(4);
          g.append("g")
              .attr("class", "x-axis")
              .attr("transform", "translate(0,"+ (height - 100) + ")")
              .call(xAxisCall)
              .selectAll("text")
              .attr("font-size", "14px")
              //.attr("transform", "rotate(-45)")
              .attr("text-anchor", "middle")
              //.attr("x","-7")
              .attr("y", "10")

          var yAxisCall = d3.axisLeft(y);
          g.append("g")
              .attr("class", "y-axis")
              .attr("transform", "translate(0,0)")
              .call(yAxisCall)
              .selectAll("text")
              .attr("font-size", "14px")

          // title

          g.append("text")
              .attr("class", "race-chart-title")
              .attr("x", 100)
              .attr("y", -32)
              .attr("font-size", "20px")
              .attr("text-anchor", "middle")
              .text("Samples Received");

      }); // close AJAX get callback
  } // close if window.pathname == dataview/superindex block
  // DATAVIEW/SUPERINDEX RACE PIE CHART
  // only do run when the user is accessing the superindex charts
  // if(window.location.pathname == '/dataview/superindex') {
  //     $.get('/dataview/superindex_race_graph.json'+'?disease[]='+superindex_disease, function(data) {
  //
  //         var margin = {left:25, right:25, top:25, bottom:25}
  //         var width = 350 - margin.left - margin.right;
  //         var height = 350 - margin.top - margin.bottom;
  //
  //         var radius = Math.min(width, height) / 2 - 50;
  //         var g = d3.select("#race-graph")
  //             .append("svg")
  //             .attr("width", width)
  //             .attr("height", height)
  //             //.attr("style", "border:1px solid green")
  //             .append("g")
  //             .attr("transform", "translate(" + (radius + margin.left * 4) + "," + (height / 1.8) + ")");
  //
  //         var colors = d3.scaleOrdinal()
  //             .domain(data.map(function(d) { return d.race } ))
  //             .range(["#333399", "#6a58b1","#9880ca","#ad95d7","#c2abe4","#d7c1f1","#ebd8ff"]);
  //
  //         var arc = d3.arc()
  //             .innerRadius(0)
  //             .outerRadius(radius);
  //
  //         var pie = d3.pie()
  //             .sort(null)
  //             .value(function (d) {
  //                 return d.samples;
  //             });
  //
  //         var pie = g.selectAll(".arc")
  //             .data(pie(data));
  //
  //         pie.enter().append("path")
  //             .attr("class", "arc")
  //             .attr("d", arc)
  //             .style("fill", function (d, i) {
  //                 return colors(d.data.race);
  //             })
  //             .attr("stroke", "white")
  //             .attr("stroke-width", "1px")
  //             .on("mouseover", function(d) {
  //                 tooltip.style("display", null);
  //                 $('#legend-race-'+ removeSpace(d.data.race)).addClass("underlineText");})
  //             .on("mouseout", function(d) {
  //                 tooltip.style("display", "none");
  //                 $('#legend-race-'+ removeSpace(d.data.race)).removeClass("underlineText");})
  //             .on("mousemove", function(d) {
  //                 var xPosition = d3.mouse(this)[0] - 30;
  //                 var yPosition = d3.mouse(this)[1] - 45;
  //                 tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
  //                 tooltip.select("text").text(d.data.samples);
  //             });
  //
  //         // legend
  //
  //         var legend = g.append("g")
  //             .attr("font-size", "12px")
  //             .attr("text-anchor", "start")
  //             .selectAll("g")
  //             .data(data.map(function(d) { return d.race }))
  //             .enter().append("g")
  //             .attr("transform", function(d, i) {
  //                 return "translate("+ -450 + ","+ ((i * 18) - 125) + ")";
  //             });
  //
  //         legend.append("rect")
  //             .attr("x", width - 50)
  //             .attr("width", 12)
  //             .attr("height", 12)
  //             .attr("fill", function(d, i) {
  //                 return colors(d);
  //             });
  //
  //         legend.append("text")
  //             .attr("x", width - 30)
  //             .attr("y", 12)
  //             .attr("id", function(d) { return "legend-race-" + removeSpace(d); })
  //             .text(function(d) {
  //                 return capitalize(d);
  //             })
  //             .attr("font-size", "14px");
  //
  //         // tooltip
  //
  //         var tooltip = g.append("g")
  //             .attr("class", "graph-tooltip")
  //             .style("display", "none");
  //
  //         tooltip.append("rect")
  //             .attr("width", 45)
  //             .attr("height", 30)
  //             .attr("fill", "black");
  //
  //         tooltip.append("text")
  //             .attr("x", 22.5)
  //             .attr("dy", "1.2em")
  //             .style("text-anchor", "middle")
  //             .attr("font-size", "16px")
  //             .attr("font-weight", "bold")
  //             .attr("fill", 'white');
  //
  //         // title
  //
  //         g.append("text")
  //             .attr("class", "race-chart-title")
  //             .attr("x", -50)
  //             .attr("y", -150)
  //             .attr("font-size", "20px")
  //             .attr("text-anchor", "middle")
  //             .text("Ancestry");
  //
  //
  //     }); //closes GET dataview/superindex_race_graph callback
  // } //closes if window location == dataview/superindex

    // DATAVIEW/SUPERINDEX SEX CHART
    if(window.location.pathname == '/dataview/superindex') {
        $.get('/dataview/superindex_sex_graph.json'+'?disease[]='+superindex_disease, function(data) {

            var margin = {left:25, right:25, top:25, bottom:25}
            var width = 350 - margin.left - margin.right;
            var height = 350 - margin.top - margin.bottom;

            var radius = Math.min(width, height) / 2 - 50;
            var g = d3.select("#sex-graph")
                //.attr("style","border: 1px solid red")
                .append("svg")
                .attr("width", width)
                .attr("height", height)
                //.attr("style", "border:1px solid green")
                .append("g")
                .attr("transform", "translate(" + (radius + margin.left * 4 - 15) + "," + (height / 1.8) + ")");

            var colors = d3.scaleOrdinal()
                .domain(data.map(function(d) { return d.sex } ))
                .range(["#333399", "#6a58b1","#9880ca","#ad95d7","#c2abe4","#d7c1f1","#ebd8ff"]);

            var arc = d3.arc()
                .innerRadius(0)
                .outerRadius(radius);

            var pie = d3.pie()
                .sort(null)
                .value(function (d) {
                    return d.samples;
                });

            var pie = g.selectAll(".arc")
                .data(pie(data));

            pie.enter().append("path")
                .attr("class", "arc")
                .attr("d", arc)
                .style("fill", function (d, i) {
                    return colors(d.data.sex);
                })
                .attr("stroke", "white")
                .attr("stroke-width", "1px")
                .on("mouseover", function(d) {
                    tooltip.style("display", null);
                    $('#legend-sex-'+ removeSpace(d.data.sex)).addClass("underlineText");
                })
                .on("mouseout", function(d) {
                    tooltip.style("display", "none");
                    $('#legend-sex-'+ removeSpace(d.data.sex)).removeClass("underlineText");
                })
                .on("mousemove", function(d) {
                    var xPosition = d3.mouse(this)[0] - 30;
                    var yPosition = d3.mouse(this)[1] - 45;
                    tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
                    tooltip.select("text").text(d.data.samples);
                });


            // legend

            var legend = g.append("g")
                .attr("font-size", "12px")
                .attr("text-anchor", "start")
                .selectAll("g")
                .data(data.map(function(d) { return d.sex }))
                .enter().append("g")
                .attr("transform", function(d, i) {
                    return "translate("+ -435 + ","+ ((i * 18) - 125) + ")";
                });

            legend.append("rect")
                .attr("x", width - 50)
                .attr("width", 12)
                .attr("height", 12)
                .attr("fill", function(d, i) {
                    return colors(d);
                });

            legend.append("text")
                .attr("x", width - 30)
                .attr("y", 12)
                .attr("id", function(d) { return "legend-sex-" + removeSpace(d); })
                .text(function(d) {
                    return capitalize(d);
                })
                .attr("font-size", "14px");

            // tooltip

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

            // title

            g.append("text")
                .attr("class", "race-chart-title")
                .attr("x", -50)
                .attr("y", -150)
                .attr("font-size", "20px")
                .attr("text-anchor", "middle")
                .text("Gender");

        }); //closes GET dataview/superindex_sex_graph callback
    } //closes if window location == dataview/superindex

    // DATAVIEW/SUPERINDEX age graph
    if(window.location.pathname == '/dataview/superindex') {
        $.get('/dataview/superindex_age_graph.json'+'?disease[]='+superindex_disease, function(data) {

            var margin = {left:45, right:0, top:25, bottom:25}
            var width = 350 - margin.left - margin.right;
            var height = 350 - margin.top - margin.bottom;

            var radius = Math.min(width, height) / 2 - 50;
            var g = d3.select("#age-graph")
                .append("svg")
                .attr("width", width)
                .attr("height", height)
                //.attr("style", "border:1px solid green")
                .append("g")
                .attr("transform", "translate(" + (radius + margin.left * 2 + 10) + "," + (height / 1.8) + ")");

            var colors = d3.scaleOrdinal()
                .domain(data.map(function(d) { return d.range } ))
                .range(["1e1c47","25266b","#333399", "#6a58b1","#9880ca","#ad95d7","#c2abe4","#d7c1f1","#ebd8ff"]);

            var arc = d3.arc()
                .innerRadius(0)
                .outerRadius(radius);

            var pie = d3.pie()
                .sort(null)
                .value(function (d) {
                    return d.samples;
                });

            var pie = g.selectAll(".arc")
                .data(pie(data));

            pie.enter().append("path")
                .attr("class", "arc")
                .attr("id", function(d) { return "pie-" + d.data.range })
                .attr("d", arc)
                .style("fill", function (d, i) {
                    return colors(d.data.range); //d.data.range
                })
                .attr("stroke", "white")
                .attr("stroke-width", "1px")
                .on("mouseover", function(d) {
                    tooltip.style("display", null);
                    $('#legend-aoo-'+ removeSpace(d.data.range)).addClass("underlineText");})
                .on("mouseout", function(d) {
                    tooltip.style("display", "none");
                    $('#legend-aoo-'+ removeSpace(d.data.range)).removeClass("underlineText");})
                .on("mousemove", function(d) {
                    var xPosition = d3.mouse(this)[0] - 30;
                    var yPosition = d3.mouse(this)[1] - 45;
                    tooltip.attr("transform", "translate(" + xPosition + "," + yPosition + ")");
                    tooltip.select("text").text(d.data.samples);
                });

            // legend

            var legend = g.append("g")
                .attr("font-size", "12px")
                .attr("text-anchor", "start")
                .selectAll("g")
                .data(data.map(function(d) { return d.range }))
                .enter().append("g")
                .attr("transform", function(d, i) {
                    return "translate("+ -450 + ","+ ((i * 18) - 125) + ")";
                });

            legend.append("rect")
                .attr("x", width - 50)
                .attr("width", 12)
                .attr("height", 12)
                .attr("fill", function(d, i) {
                    return colors(d);
                });

            legend.append("text")
                .attr("x", width - 30)
                .attr("y", 12)
                .attr("id", function(d) { return "legend-aoo-" + removeSpace(d); })
                .text(function(d) {
                    return d;
                })
                .attr("font-size", "14px");

            // tooltip

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

            // title

            g.append("text")
                .attr("class", "race-chart-title")
                .attr("x", -50)
                .attr("y", -150)
                .attr("font-size", "20px")
                .attr("text-anchor", "middle")
                .text("Age of Onset (range)");

        }); //closes GET dataview/superindex_sex_graph callback
    } //closes if window location == dataview/superindex
});
