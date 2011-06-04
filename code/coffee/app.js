(function() {
  var x;
  x = 5;
  $('#item_disable').click(function(e) {
    console.log("Disable!");
    $("#item_form :input").disable();
    return e.preventDefault();
  });
  $('#item_enable').click(function(e) {
    console.log("Enable!");
    $("#item_form :input").enable();
    return e.preventDefault();
  });
  $('#item_toggle').click(function(e) {
    console.log("Toggle!");
    $("#item_form :input").toggle_enable();
    return e.preventDefault();
  });
}).call(this);
