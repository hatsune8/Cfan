/*global $*/
$(document).on('turbolinks:load', function() {
$(".theTarget").skippr({
  transition : 'fade',
  speed : 5000,
  easing : 'easeOutQuart',
  navType : 'bubble',
  childrenElementType : 'div',
  arrows : true,
  autoPlay : true,
  autoPlayDuration : 2000,
  keyboardOnAlways : true,
  hidePrevious : true,
});
});