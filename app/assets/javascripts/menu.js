$(document).on('page:change', function(){
  $('.toggleMenu').on('click', function() {
    $('.Menu').toggleClass('Menu--active')
  });
});
