// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
//
//= require jquery
//= require jquery_ujs
//= require popper
//= require my_script
//= require turbolinks
//= require bootstrap-tokenfield
//= require bootstrap-wysihtml5
//=require_tree ./admin
//= require_tree ./channels
//= require ./cable.js
$(document).on('turbolinks:load', function() {
  $('.data-table').DataTable({
    "paging": true,
    "lengthChange": false,
    "searching": false,
    "ordering": true,
    "info": true,
    "autoWidth": false,
  });
})
