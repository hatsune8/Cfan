/*global $*/
$(document).on('turbolinks:load', function() {
$(".theTarget").skippr({
  transition : 'slide',
  speed : 1000,
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