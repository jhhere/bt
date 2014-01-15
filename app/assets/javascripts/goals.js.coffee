# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#user_goals').sortable
    axis: 'y'
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))

  $('#user_goals').on 'click', 'li.goal button', (e) ->
    $(e.target).parents('li.goal').find('.name').append('working?')