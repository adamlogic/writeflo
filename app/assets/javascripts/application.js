//= require jquery
//= require jquery_ujs

$(function() {
  var $doc = $('#doc-content');
  var padding = $doc.outerHeight() - $doc.height();
  $doc.height($(window).height() - padding);
  $doc.focusAtEndOfText();
});

$.fn.focusAtEndOfText = function () {
  var el = this[0];

  if (typeof el.selectionStart == "number") {
    el.selectionStart = el.selectionEnd = el.value.length;
  } else if (typeof el.createTextRange != "undefined") {
    el.focus();
    var range = el.createTextRange();
    range.collapse(false);
    range.select();
  }
}
