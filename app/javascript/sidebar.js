$(document).on('turbolinks:load', function() {
  let isCollapsed = false;

  set_chat_height();
  collapse_sidebar();
  
  function collapse_sidebar(){
    $("#sidebar_button_icon").removeClass("bi-file-excel");
    $("#sidebar_button_icon").addClass("bi-list");
    $( "#sidebar" ).hide();
    isCollapsed = true;
  }

  function expand_sidebar(){
    $("#sidebar_button_icon").removeClass("bi-list");
    $("#sidebar_button_icon").addClass("bi-file-excel");
    $( "#sidebar" ).show();
    isCollapsed = false;
  }

  $("#sidebarCollapse").click(function(){
    if (!isCollapsed) {
      collapse_sidebar();
    } else {
      expand_sidebar();
    }
  });

  function set_chat_height(){
    if ($('#chat').height() > $('#story').height()) {
      $('#chat').css('height', $('#story').height());
      $('#chat').css('border', '1px solid');
    }
  }

  $(window).resize(function(){
    set_chat_height();
  });
});