//= require jquery
//= require jquery_ujs

$(function() {
  var $anchor, $selection;

  $('.reviewable-doc-content').on('mousedown', 'span', beginSelection)
                              .on('mouseover', 'span', extendSelection);
  $(document).on('mouseup', completeSelection);

  function beginSelection(e) {
    clearSelection();
    $selection = $anchor = $(this);
    $selection.addClass('is-selected');
  }

  function extendSelection(e) {
    if (isMakingSelection()) {
      clearSelection();
      var $endPoint = $(this);

      if ($anchor.is($endPoint)) {
        $selection = $anchor;
      } else if ($anchor.nextAll().is($endPoint)) {
        $selection = $anchor.nextUntil($endPoint).add($anchor).add($endPoint);
      } else if ($anchor.prevAll().is($endPoint)) {
        $selection = $anchor.prevUntil($endPoint).add($anchor).add($endPoint);
      }

      $selection.addClass('is-selected');
    }
  }

  function isMakingSelection() {
    return $anchor;
  }

  function clearSelection() {
    $('.reviewable-doc-content').find('.is-selected').removeClass('is-selected');
    $selection = null;
  }

  function completeSelection(e) {
    $anchor = null;
  }

});
