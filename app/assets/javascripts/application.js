// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require vue
//= require popper
//= require bootstrap
//= require local-time
//= require_tree .

$(document).ready(function(){
  $('.alert').fadeIn(500).delay(1000).fadeOut(1000);
});

onSubmitClick = function() {
  $("#scroll-container").stop().animate({ scrollTop: $("#scroll-container")[0].scrollHeight}, 1000);
  setTimeout(function(){
    $('.message-input').val('');
  });
}

onChatSubmitClick = function() {
  setTimeout(function(){
    $('.add-chat').val('');
  });
}
