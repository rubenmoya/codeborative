$(document).on('page:change', function(){
  $('.Friendlist-header').on('click', function() {
    $('.Friendlist-body').toggle();
    $('.Friendlist-header .options i').toggleClass('fa-angle-down fa-angle-up');
  })
});
