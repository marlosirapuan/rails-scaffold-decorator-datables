// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// jQuery
import $ from 'jquery'
window.jQuery = $
window.$ = $

// DataTables
require('jszip')
require('pdfmake')
require('datatables.net-bs4')
require('datatables.net-buttons-bs4')
require('datatables.net-buttons/js/buttons.html5.js')
require('datatables.net-buttons/js/buttons.print.js')
require('datatables.net-fixedheader-bs4')
require('datatables.net-responsive-bs4')

//
// DataTable default options
//
$.extend(true, $.fn.dataTable.defaults, {
  processing: true,
  serverSide: true,
  pagingType: 'full_numbers',
  lengthChange: true,
  select: true,
  dom:
    '<"mb-3"B><"d-flex justify-content-between"<"left"f><"right"l>><"wrapper"rtip>',
  buttons: [
    { extend: 'copy', text: 'Copiar' },
    { extend: 'pdf', text: 'PDF' },
    { extend: 'csv', text: 'CSV' },
    { extend: 'print', text: 'Imprimir' }
  ],
  language: {
    lengthMenu: 'Mostrar _MENU_ registros',
    sEmptyTable: 'Nenhum registro encontrado',
    sInfo: 'Mostrando de _START_ até _END_ de _TOTAL_ registros',
    sInfoEmpty: 'Mostrando 0 até 0 de 0 registros',
    sInfoFiltered: '(filtrado de _MAX_ registros)',
    sLoadingRecords: 'Carregando...',
    sProcessing: 'Processando...',
    sZeroRecords: 'Nenhum registro encontrado',
    sSearch: 'Pesquisar',
    search: '_INPUT_',
    searchPlaceholder: 'Pesquisar...',
    zeroRecords: 'Nenhum registro encontrado.',
    info: 'Mostrando _END_ de _TOTAL_ registros',
    paginate: {
      first: 'Primeiro',
      previous: '&#8592;',
      next: '&#8594;',
      last: 'Último'
    }
  }
})

//
// Pipelining function for DataTables. To be used to the `ajax` option of DataTables
//
$.fn.dataTable.pipeline = function (opts) {
  // Configuration options
  var conf = $.extend(
    {
      pages: 5, // number of pages to cache
      url: '', // script url
      data: null, // function or object with parameters to send to the server
      // matching how `ajax.data` works in DataTables
      method: 'GET' // Ajax HTTP method
    },
    opts
  )

  // Private variables for storing the cache
  var cacheLower = -1
  var cacheUpper = null
  var cacheLastRequest = null
  var cacheLastJson = null

  return function (request, drawCallback, settings) {
    var ajax = false
    var requestStart = request.start
    var drawStart = request.start
    var requestLength = request.length
    var requestEnd = requestStart + requestLength

    if (settings.clearCache) {
      // API requested that the cache be cleared
      ajax = true
      settings.clearCache = false
    } else if (
      cacheLower < 0 ||
      requestStart < cacheLower ||
      requestEnd > cacheUpper
    ) {
      // outside cached data - need to make a request
      ajax = true
    } else if (
      JSON.stringify(request.order) !==
        JSON.stringify(cacheLastRequest.order) ||
      JSON.stringify(request.columns) !==
        JSON.stringify(cacheLastRequest.columns) ||
      JSON.stringify(request.search) !== JSON.stringify(cacheLastRequest.search)
    ) {
      // properties changed (ordering, columns, searching)
      ajax = true
    }

    // Store the request for checking next time around
    cacheLastRequest = $.extend(true, {}, request)

    if (ajax) {
      // Need data from the server
      if (requestStart < cacheLower) {
        requestStart = requestStart - requestLength * (conf.pages - 1)

        if (requestStart < 0) {
          requestStart = 0
        }
      }

      cacheLower = requestStart
      cacheUpper = requestStart + requestLength * conf.pages

      request.start = requestStart
      request.length = requestLength * conf.pages

      // Provide the same `data` options as DataTables.
      if (typeof conf.data === 'function') {
        // As a function it is executed with the data object as an arg
        // for manipulation. If an object is returned, it is used as the
        // data object to submit
        var d = conf.data(request)
        if (d) {
          $.extend(request, d)
        }
      } else if ($.isPlainObject(conf.data)) {
        // As an object, the data given extends the default
        $.extend(request, conf.data)
      }

      settings.jqXHR = $.ajax({
        type: conf.method,
        url: conf.url,
        data: request,
        dataType: 'json',
        cache: false,
        success: function (json) {
          cacheLastJson = $.extend(true, {}, json)

          if (cacheLower != drawStart) {
            json.data.splice(0, drawStart - cacheLower)
          }
          if (requestLength >= -1) {
            json.data.splice(requestLength, json.data.length)
          }
          drawCallback(json)
        }
      })
    } else {
      json = $.extend(true, {}, cacheLastJson)
      json.draw = request.draw // Update the echo for each response
      json.data.splice(0, requestStart - cacheLower)
      json.data.splice(requestLength, json.data.length)

      drawCallback(json)
    }
  }
}

// Register an API method that will empty the pipelined data, forcing an Ajax
// fetch on the next draw (i.e. `table.clearPipeline().draw()`)
$.fn.dataTable.Api.register('clearPipeline()', function () {
  return this.iterator('table', function (settings) {
    settings.clearCache = true
  })
})
