// // # Place all the behaviors and hooks related to the matching controller here.
// // # All this logic will automatically be available in application.js.
// // # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on("turbolinks:load", function() {

  var superindex_disease = $('#superindex-disease').text();

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
      ],
      "columns": [
          {"render": function(data, type, row, meta) {
                  if (data) {
                      return '<a data-toggle='+"modal"+' data-target="#sample-modal" >'+data+'</a>';
                  }
                  else {
                      return '-';
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
      ]
  });

  $('#samples-superindex-table').on('draw.dt', function() {
      $('[data-toggle=modal]').on('click', function(e){
          e.preventDefault();
          //console.log($(this).data("target"))
           $(this).data('triggered', true);
          //console.log($(this).data('triggered'))
          $.get('/dataview/modal_content.json?indigo_id='+e.target.text, function(data) {
             if ($(this).data('triggered')) {
                 $('#modal-indigo-id').text(data.study_id);
                 $(this).modal().data('triggered', false)
             }

          });

      });

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

  var tables = {
    "samples-index-table":samples_index_table,
    "hlas-index-table":hlas_index_table,
    "kirs-index-table":kirs_index_table,
    "samples-superindex-table":samples_superindex_table,
    "hlas-superindex-table":hlas_superindex_table,
    "kirs-superindex-table":kirs_superindex_table
  }


  $('.show-column-checkbox').on('change', function(){
    var table = tables[$(this).data("table-id")];
    var col = $(this).data("column");
    var checked = $(this).prop("checked");
    table.columns(col).visible(checked);
  })
});
