/* global $ App */
const commentTemplate = require('./templates/comments/comment.hbs')
const commentForm = require('./templates/comments/form.hbs')
const errorsTemplate = require('./templates/shared/errors.hbs')

export function initComments () {
  subscribeOnComments()
  onCreateSuccess()
  onNewSuccess()
  onEditSuccess()
  onUpdateSuccess()
  handleErorrs()
}

function subscribeOnComments () {
  if (App.sub !== undefined) {
    App.sub.unsubscribe()
    delete (App.sub)
  }
  App.sub = App.cable.subscriptions.create({ channel: 'CommentsChannel', post_id: currentPostId() },
    {
      received: function (data) {
        switch (data.action) {
          case 'create':
            appendNewComment(data)
            break
          case 'update':
            updateComment(data)
            break
          case 'destroy':
            destroyComment(data)
            break
        }
      }
    })
}

function appendNewComment (data) {
  $('.comments-content').prepend(commentTemplate(data))
}

function updateComment (data) {
  $('#comment-' + data.comment.id).replaceWith(commentTemplate(data))
}

function destroyComment (data) {
  $('#comment-' + data.comment.id).remove()
}

function currentPostId () {
  return $('article.post-show').data('post-id')
}

function onNewSuccess () {
  $('.new-comment-btn').on('ajax:success', function (e) {
    $(this).hide()
    var comment = e.detail[0]
    comment.class = 'new_comment'
    comment.method = 'post'
    $('.comments-form').empty()
      .append(commentForm(comment))
  })
}

function onCreateSuccess () {
  $('.comments-form').on('ajax:success', '.new_comment', function (e) {
    $(this).remove()
    $('.new-comment-btn').show()
  })
}

function onEditSuccess () {
  $('.comments-content').on('ajax:success', 'a.comment-edit', function (e) {
    $('.new-comment-btn').hide()
    var comment = e.detail[0]
    comment.class = 'edit_comment'
    comment.method = 'patch'
    $('.comments-form').empty()
      .append(commentForm(comment))
  })
}

function onUpdateSuccess () {
  $('.comments-form').on('ajax:success', '.edit_comment', function (e) {
    $(this).remove()
    $('.new-comment-btn').show()
  })
}

function handleErorrs () {
  $('.comments-form').on('ajax:error', 'form', function (e) {
    var errors = e.detail[0]
    $(this).prepend(errorsTemplate(errors))
  })
}
