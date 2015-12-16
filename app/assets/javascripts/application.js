//= require jquery
//= require jquery_ujs
//= require selectize
//= require ace-rails-ap
//= require ace/theme-monokai
//= require ace/mode-javascript
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require notifications
//= require tags
//= require chat
//= require users
//= require messages
//= require_self

$(document).on('page:change', function(){
  $('.toggleMenu').on('click', function() {
    $('.Menu').toggleClass('Menu--active')
  });

  $('.Friendlist-header').on('click', function() {
    $('.Friendlist-body').toggle();
    $('.Friendlist-header .options i').toggleClass('fa-angle-down fa-angle-up');
  })
});
