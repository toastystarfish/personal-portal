
function display_notifly () {
  var delay=0;

  if(document.documentElement.hasAttribute("data-turbolinks-preview")) {
    // turbolinks is previewing the page, we dont execute unless its an actual
    // page load
    return;
  }

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
  $(msg).clearQueue().animate({right: '150%'}, 250);
}
