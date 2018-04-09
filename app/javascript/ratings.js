/* global $ */
const ratingTemplate = require('./templates/ratings/rating.hbs')
const ratingForm = require('./templates/ratings/form.hbs')

export function initRatings () {
  loadRating()
  onResponseSuccess()
}

function loadRating () {
  var profileID = $('[data-profile-id]').data('profile-id')
  $.ajax({
    type: 'GET',
    url: `/users/${profileID}/ratings`,
    success: function (data) {
      if (data.state === 'rating') {
        appendRatingTemplate(ratingTemplate, data)
      } else if (data.state === 'form') {
        appendRatingTemplate(ratingForm, data)
      }
    }
  })
}

function appendRatingTemplate (template, data) {
  $('.rating-inputs').empty().append(template(data))
}

function onResponseSuccess () {
  $('.rating-inputs').on('ajax:success', '.new_rating, a.remove', function (e) {
    var rating = e.detail[0]
    var behaviour = $(this).data('behaviour')
    if (behaviour === 'form') {
      appendRatingTemplate(ratingTemplate, rating)
    } else {
      appendRatingTemplate(ratingForm, rating)
    }
    $('.rating-average span').text(rating.average)
  })
}
