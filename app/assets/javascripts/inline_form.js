
$(document).on('submit', 'form.inline-form', function () {
  var form = this;
  $(form).find('span[contenteditable]').each(function () {
    $(form).find('#'+$(this).data('input-id')).val($(this).text());
  });
});

// prevents user from hitting Enter and creating multiline
// in the inline editable span tag - nw
$(document).on('keypress', 'form.inline-form', function (event) {
  if (event.keyCode == 13) {
    event.preventDefault();
    return false;
  }
});

$(document).on('keyup', 'form.inline-form', function () {
  var form  = this,
      input = $(form).find('#'+$(this).data('input-id'));

  if ($(this).text() != input.val()) {
    $(form).find('.inline-form-changed').fadeIn();
  }
});
