/* global $ */
import {initComments} from '../comments.js'
import {initFavorites} from '../favorites.js'
import {initImages} from '../images.js'
import {initRatings} from '../ratings.js'
import {initTags} from '../tags.js'
import {initUsers} from '../users.js'

$(document).on('turbolinks:load', function () {
  $('[data-init]').each(function () {
    var init = $(this).data('init')
    switch (init) {
      case 'comments':
        initComments()
        break
      case 'favorites':
        initFavorites()
        break
      case 'images':
        initImages()
        break
      case 'ratings':
        initRatings()
        break
      case 'tags':
        initTags()
        break
      case 'users':
        initUsers()
        break
    }
  })
})
