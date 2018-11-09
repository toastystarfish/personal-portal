// On click:
// - Close open overlays (except the overlay this click originated in, if any)
// - Open any overlays this element is linked to (if not already open)
$(document).on('click', function(e) {
  var closest_overlay_key     = e.target.closest('[data-overlay-key]'),
      closest_overlay_content = e.target.closest('[data-overlay-content]'),
      overlay_key_str = $(closest_overlay_key).data('overlay-key'),
      overlay_content = $('[data-overlay-content=\'' + overlay_key_str + '\']');

  // Close open overlays (except the overlay this click originated in, if any)
  overlay_fade_out($('[data-overlay-content]:visible').not(closest_overlay_content));

  // Wait for show() to complete before adding .is-open (otherwise will not
  // show transition)
  overlay_content.not(":visible").show(0, function() {
    overlay_content.addClass('is-open');
  });
});

// Remove .is-open, allow overlay can transition out, then hide the element
function overlay_fade_out(overlay_content) {
  overlay_content.removeClass('is-open').one('transitionend', function() {
    overlay_content.hide();
  });
}
