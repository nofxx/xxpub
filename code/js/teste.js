$(document).ready(function(){
  // Your code here


// $('a').click(function(event){
//   alert('As you can see, the link no longer took you to jquery.com');
//   event.preventDefault();
// });

  $('p').click(function(event){
    event.preventDefault();
    $(this).hide('slow');
  });
  
  
  $('#some_id').click(function(event){
    event.preventDefault();
    $(this).slideDown('slow');
  });
  
  $('.some_class').click(function(event){
    event.preventDefault();
    $(this).slideUp('slow');
  });
  
});
