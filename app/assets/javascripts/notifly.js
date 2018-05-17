
function display_notifly () {
  var delay=0;

  $('#notifly .wrapper:not(:visible)').each(function () {
    var self = this;

    $(this).show()
    setTimeout(function() {
      $(self).animate({right: '0%'}, 250)
      .delay(5000).fadeOut('slow', function () {
        $(self).remove();
      });
    }, delay);

    delay += 250;
  });
}

$(document).on('click', '#notifly .closer', function () {
  close_notifly_message(this.parentNode);
});

function close_notifly_message (msg) {
  $(msg).clearQueue().animate({right: '150%'}, 250, function () {
      $('#notifly').hide();
  });
}
