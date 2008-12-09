$(document).ready(function () {
  $("<p>BAcanis</p>").insertAfter("#tryMe");
  $("#hideMe").hide("slow");
  $("#tryMe").fadeOut();
  $("#tryMe").fadeIn();

  $("#showMe").hide();
  $("#showMe").show("slow");

  $("#showMe").val("slow mote");
  $("#showMe").show("slow");



// $('a').click(function(event){
//   alert('As you can see, the link no longer took you to jquery.com');
//   event.preventDefault();
// });

  $('p').click(function(event){
    event.preventDefault();
//    $(this).hide('slow');
    $(this).addClass('bg_red');
  });

  $('p:contains("Magic")').addClass('highlight');


  $('#some_id').click(function(event){
    event.preventDefault();
    $(this).slideDown('slow');
  });

  $('.some_class').click(function(event){
    event.preventDefault();
    $(this).slideUp('slow');
  });





});
