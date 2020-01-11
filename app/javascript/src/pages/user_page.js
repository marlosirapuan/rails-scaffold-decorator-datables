document.addEventListener("turbolinks:load", function () {
  $('#users-datatable').dataTable({
    ajax: {
      url: $('#users-datatable').data('source')
    },
    columns: [
      { data: 'id' },
      { data: 'name' },
      { data: 'email' },
      { data: 'is_admin' },
      { data: 'status' },
      { data: 'actions' }
    ]
  })
})
