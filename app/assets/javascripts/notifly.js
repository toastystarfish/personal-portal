
function display_notifly () {
  var delay = 0;
  var notification_duration = 5000 // Time before notificiation auto-closes

  $('#notifly .wrapper').each(function () {
    var self = this;

    $(this).addClass('animate-in');

    setTimeout(function() {
      // Animate out after 5 seconds
      setTimeout(function() {
        $(self).addClass('animate-out').on('animationend', function () {
          $(self).remove();
        });
      }, notification_duration)
    // Add an extra delay for each additional notification
    }, delay);

    delay += 250;
  });
}

$(document).on('click', '#notifly .closer', function () {
  close_notifly_message(this.parentNode);
});

function close_notifly_message (msg) {
  $(msg).clearQueue().addClass('animate-out').on('animationend', function () {
    $(msg).remove();
  });
}
