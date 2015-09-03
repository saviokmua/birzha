// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require select2
//= require select2_locale_"uk"
//= require turbolinks
//= require ckeditor/init
//= require jquery.validate
//= require jquery.validate.additional-methods
//= require jquery.validate.localization/messages_uk

$(document).ready(function () {
$("#new_feedback").validate({
debug: true,
rules: {
"feedback[name]": {required: true},
"feedback[email]": {required: true, email: true},
}
});
});

  
  function auction_enable(){
  $('.auction_enable').on('click',function(){
    
    $( ".auction_id" ).toggle();
    $( ".content" ).toggle();

  })
}

function form_search_order(){
  /**
  set order type and submit search form
  */
  $('.form_search_order').on('click',function() {
    form_id=$(this).closest('form').attr('id');
    $("#search_order").val($(this).data('order'));
    $('#'+form_id).submit();
  })
}



  function feedback_valid() {
    
    $("#new_feedback").validate();
  };



$(document).ready(auction_enable);
$(document).on('page:load', auction_enable);
$(document).ready(form_search_order);
$(document).on('page:load', form_search_order);


