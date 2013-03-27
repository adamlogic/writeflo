//= require jquery
//= require jquery_ujs

$(function() {
  var $doc = $('#doc-content');
  var padding = $doc.outerHeight() - $doc.height();
  $doc.height($(window).height() - padding);
});
