//= require jquery
//= require jquery_ujs

$(function() {
  //TODO: also handle dblclick event
  //TODO: handle selections across paragraphs

  var $anchor = null;

  $('.reviewable-doc-content').on('mousedown', 'span', function(e) {
    clearSelection();
    $anchor = $(this);
    $anchor.addClass('is-selected');
  }).on('mouseover', 'span', function(e) {
    if ($anchor) {
      clearSelection();
      var $endPoint = $(this);

      if ($anchor.is($endPoint)) {
        $anchor.addClass('is-selected');
      } else if ($anchor.nextAll().is($endPoint)) {
        $anchor.nextUntil($endPoint).add($anchor).add($endPoint).addClass('is-selected');
      } else if ($anchor.prevAll().is($endPoint)) {
        $anchor.prevUntil($endPoint).add($anchor).add($endPoint).addClass('is-selected');
      }
    }
  });

  $(document).on('mouseup', function(e) {
    $anchor = null;
  });

  function clearSelection() {
    $('.reviewable-doc-content').find('.is-selected').removeClass('is-selected');
  }
});
