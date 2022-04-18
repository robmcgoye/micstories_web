// $(document).on('turbolinks:load', function() {
$(document).ready (function() {
  let isCollapsed = false;
  // ----------------------
  // tinymce.remove();
  // tinymce.init({selector:'.tinymce'});
  // ----------------------
  set_chat_height();
  collapse_sidebar();
  // ----------------------  
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
    $("#sidebarCollapse").removeClass("sidebar-btn");
    $("#sidebarCollapse").addClass("sidebar-btn");
  });

  function set_chat_height(){
    let max_height = $('#story').height() + $('#story_header').height();
    // let chat_height = $('#chat').height() + $('#chat_header').height();
    // if (chat_height > max_height) {
      $('#chat').css('height', (max_height - $('#chat_header').height()));
      $('#chat').css('border', '1px solid');
    // }
    let side_height = $('#sidebarCollapse').height() + max_height;
    
    // console.log(`max height = ${ max_height }`);
    // console.log(`button height = ${ $('#sidebarCollapse').height() }`);   
    // console.log(`sidebar height = ${ side_height }`);
    $('#sidebar').css('height', side_height);
  }

  $(window).resize(function(){
    set_chat_height();
  });
});