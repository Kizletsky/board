/* global $ */
const ratingTemplate = require('./templates/ratings/rating.hbs')
const ratingForm = require('./templates/ratings/form.hbs')

export function initRatings () {
  appendRating()
  removeRating()
}

function appendRating () {
  $('.rating-inputs').on('ajax:success', '.new_rating', function (e) {
    var rating = e.detail[0]
    $(this).replaceWith(ratingTemplate(rating))
    $('.rating-average span').text(rating.average)
  })
}

function removeRating () {
  $('.rating-inputs').on('ajax:success', 'a.remove', function (e) {
    var rating = e.detail[0]
    $('.rating').replaceWith(ratingForm(rating))
    $('.rating-average span').text(rating.average)
  })
}
