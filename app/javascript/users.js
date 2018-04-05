/* global $ */

export function initUsers () {
  $('.user-remove').on('ajax:success', function (e) {
    $('#user-row-' + e.detail[0]).remove()
  })
}
