/* global $ */
const favoriteTemplate = require('./templates/favorites/favorite.hbs')
const addLink = require('./templates/favorites/add_link.hbs')
const removeLink = require('./templates/favorites/remove_link.hbs')

export function initFavorites () {
  getUserFavorites()
  appendFavorite()
  removeFromFavorites()
  dontCloseDropdown()
}

function getUserFavorites () {
  $('#favorite-posts > a').on('click', function () {
    if ($(this).attr('aria-expanded') === 'false') {
      $.ajax({
        type: 'GET',
        url: '/favorites',
        success: function (data) {
          $('.favorite-posts').empty()
          data.forEach(function (el) {
            $('.favorite-posts').append(favoriteTemplate(el))
          })
        }
      })
    }
  })
}

function appendFavorite () {
  $('.favorite-link').on('ajax:success', 'a.add', function (e) {
    var post = e.detail[0]
    $('.favorite-posts').append(favoriteTemplate(post))
    $(this).replaceWith(removeLink(post))
  })
}

function removeFromFavorites () {
  $('.favorite-link').on('ajax:success', 'a.remove', function (e) {
    var post = e.detail[0]
    $('.favorite-post' + post.id).remove()
    $(this).replaceWith(addLink(post))
  })
  $('.favorite-posts').on('ajax:success', 'a', function (e) {
    var post = e.detail[0]
    $('.favorite-post' + post.id).remove()
    $('.favorite-link-container-' + post.id + ' > .favorite-link').empty().append(addLink(post))
  })
}

function dontCloseDropdown () {
  $('ul.favorite-posts').on('click', function (e) {
    e.stopPropagation()
  })
}
