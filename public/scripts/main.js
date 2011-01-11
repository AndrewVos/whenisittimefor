$(document).ready(function(){
  $("#date").focus();

  $("#title_text").click(function(){
    $("#delete_date").submit();
  });

  $(".center").center();
  $(window).bind("resize", function() {
    $(".center").center();
  });
});
