// // # Place all the behaviors and hooks related to the matching controller here.
// // # All this logic will automatically be available in application.js.
// // # You can use CoffeeScript in this file: http://coffeescript.org/
$(function() {
//   var table_filters = [];
//   function catFilters() {
//     var filter_string = table_filters.join(', ')
//     $('#filter-list').html(filter_string);
//   }
  var table = $('#stacy-samples-table').DataTable({
    "autoWidth":false,
    "pageLength":100,
    "bServerSide":true,
    "bProcessing":true,
    "bPaginate":true,
    "sAjaxSource":$('stacy-samples-table').data("source"),
    "pagingType":"full_numbers",
    "paging":true,
    "lengthMenu":[10,25,50,100,250]
  });
//   $('#back-btn').click(function(){
//     $.fn.dataTable.ext.search.pop();
//     table.draw();
//     table_filters.pop();
//     catFilters();
//   });
//   $('#has-hla-btn').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-has-hla') === "true";
//       }
//     );
//     table.draw();
//     table_filters.push("Has HLA");
//     catFilters();
//   });
//   $('#no-hla-btn').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-has-hla') === "false";
//       }
//     );
//     table.draw();
//     table_filters.push("No HLA");
//     catFilters();
//   });
//   $('#has-kir-btn').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-has-kir') === "true";
//       }
//     );
//     table.draw();
//     table_filters.push("Has KIR genotypes");
//     catFilters();
//   });
//   $('#no-kir-btn').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-has-kir') === "false";
//       }
//     );
//     table.draw();
//     table_filters.push("No KIR genotypes");
//     catFilters();
//   });
//   $('#has-raw-kir-btn').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-has-raw-kir') === "true";
//       }
//     );
//     table.draw();
//     table_filters.push("Has raw KIR data");
//     catFilters();
//   });
//   $('#no-raw-kir-btn').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-has-raw-kir') === "false";
//       }
//     );
//     table.draw();
//     table_filters.push("No raw KIR data");
//     catFilters();
//   });
//
//   //filter by case/control actions
//   $('#case').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-disease') !== "HC";
//       }
//     );
//     table.draw();
//     table_filters.push("Cases");
//     catFilters();
//   });
//     $('#control').click(function() {
//       $.fn.dataTable.ext.search.push(
//         function(settings, data, dataIndex) {
//           return $(table.row(dataIndex).node()).attr('data-disease') === "HC";
//         }
//       );
//       table.draw();
//       table_filters.push("Controls");
//       catFilters();
//   });
//
//   // filter by location actions
//   $('#besta').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-source') === "Besta";
//       }
//     );
//     table.draw();
//     table_filters.push("Besta Institute");
//     catFilters();
//   });
//   $('#mjff').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-source') === "MJ";
//       }
//     );
//     table.draw();
//     table_filters.push("MJ Fox Foundation");
//     catFilters();
//   });
//   $('#nih').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-source') === "NIH";
//       }
//     );
//     table.draw();
//     table_filters.push("NIH");
//     catFilters();
//   });
//   $('#oslo').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-source') === "Oslo";
//       }
//     );
//     table.draw();
//     table_filters.push("Oslo University Hospital");
//     catFilters();
//   });
//   $('#ucsf').click(function() {
//     $.fn.dataTable.ext.search.push(
//       function(settings, data, dataIndex) {
//         return $(table.row(dataIndex).node()).attr('data-source') === "UCSF";
//       }
//     );
//     table.draw();
//     table_filters.push("UCSF");
//     catFilters();
//   });
})
