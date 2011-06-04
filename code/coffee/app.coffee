#
# jQuery Playground
#

$('#item_disable').click (e) ->
  console.log("Disable!")
  $("#item_form :input").disable()
  e.preventDefault()


$('#item_enable').click (e) ->
  console.log("Enable!")
  $("#item_form :input").enable()
  e.preventDefault()


$('#item_toggle').click (e) ->
  console.log("Toggle!")
  $("#item_form :input").toggle_enable()
  e.preventDefault()