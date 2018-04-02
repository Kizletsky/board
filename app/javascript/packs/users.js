/* global $ */

$(document).on('turbolinks:load', function () {
  $('.user-remove').on('ajax:success', function (e) {
    $('#user-row-' + e.detail[0]).remove()
  })
})
