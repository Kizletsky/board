/* global $ */
const commentTemplate = require('../templates/comments/comment.hbs')
const commentForm = require('../templates/comments/form.hbs')
const errorsTemplate = require('../templates/shared/errors.hbs')

$(document).on('turbolinks:load', function () {
  createComment()
  newComment()
  editComment()
  updateComment()
  destroyComment()
  handleErorrs()
})

function newComment () {
  $('.new-comment-btn').on('ajax:success', function (e) {
    $(this).hide()
    var comment = e.detail[0]
    comment.class = 'new_comment'
    comment.method = 'post'
    $('.comments-form').empty()
      .append(commentForm(comment))
  })
}

function createComment () {
  $('.comments-form').on('ajax:success', '.new_comment', function (e) {
    var data = e.detail[0]
    $('.comments-content').prepend(commentTemplate(data))
    $(this).remove()
    $('.new-comment-btn').show()
  })
}

function editComment () {
  $('.comments-content').on('ajax:success', 'a.comment-edit', function (e) {
    $('.new-comment-btn').hide()
    var comment = e.detail[0]
    comment.class = 'edit_comment'
    comment.method = 'patch'
    $('.comments-form').empty()
      .append(commentForm(comment))
  })
}

function updateComment () {
  $('.comments-form').on('ajax:success', '.edit_comment', function (e) {
    var comment = e.detail[0]
    $('#comment-' + comment.id).replaceWith(commentTemplate(comment))
    $(this).remove()
    $('.new-comment-btn').show()
  })
}

function destroyComment () {
  $('.comments-content').on('ajax:success', 'a.comment-delete', function (e) {
    var comment = e.detail[0]
    $('#comment-' + comment.id).remove()
  })
}

function handleErorrs () {
  $('.comments-form').on('ajax:error', 'form', function (e) {
    var errors = e.detail[0]
    $(this).prepend(errorsTemplate(errors))
  })
}
