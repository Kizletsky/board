/* global $ */

$(document).on('turbolinks:load', function () {
  $('#favorite-posts > a').on('click', function () {
    if ($(this).attr('aria-expanded') === 'false') {
      $.ajax({
        type: 'GET',
        url: '/favorites'
      })
    };
  })
})
