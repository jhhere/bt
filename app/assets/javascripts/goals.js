// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

jQuery(function() {
  $('#user_goals').sortable({
    axis: 'y',
    update: function() {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });

  $('body > .container').on('click', 'li.goal button', function(e) {

    button = $(e.target);

    if (button.parents('button').length ) {
      button = button.parents('button');
    }

    goal = button.parents('li.goal')

    if (button.hasClass("up")) {
      prevGoal = goal.prev('li.goal');
      console.log(prevGoal);
      prevGoal.insertAfter(goal);
    } else {
      nextGoal = goal.next('li.goal');
      console.log(nextGoal);
      nextGoal.insertBefore(goal);
    }
    $.post($('#user_goals').data('update-url'), $('#user_goals').sortable('serialize'));
  });

});


