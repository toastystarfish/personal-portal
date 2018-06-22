
// Any click on an overlay container will:
// - close all open overlays
// - open this overlay, if it is not already open
$(document).on('click', '[data-overlay=\'overlay_container\']', function (e) {
  var overlay_content = $(this).find('[data-overlay=\'overlay_content\']');
  e.stopPropagation();
  // Close all open overlays
  overlay_fade_out($('[data-overlay=\'overlay_content\']:visible'));
  // Close the overlay if visible; otherwise show it
  if (!overlay_content.is(':visible')) {
    overlay_content.show().addClass('anim-overlay-in');
  }
});

// Clicking anywhere on the page body while an overlay is open should close it
$(document).on('click', 'body', function (e) {
  overlay_fade_out($('[data-overlay=\'overlay_content\']:visible'));
});

// Add class to animate out, and use event listener to hide the element once done
function overlay_fade_out(overlay_content) {
  overlay_content.addClass('anim-overlay-out').one('animationend', function() {
    overlay_content.removeClass('anim-overlay-out anim-overlay-in').hide();
  });
}
