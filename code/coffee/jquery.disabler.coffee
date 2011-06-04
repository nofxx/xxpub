#
# Stupid plugin to learn
#
$ = jQuery

#
# 1
#
$.extend $.fn,
  enable: ->
    @each  ->
      e = $(@)
      e.attr("disabled", false) if e.is("button") or e.is("input")

#
# 2
#
$.fn.disable = () ->
  @each ->
    e = $(@)
    e.attr("disabled", true) if e.is("button") or e.is("input")

#
# 3
#
do ($ = jQuery) ->
  $.fn.toggle_enable = ->
    @each ->
      e = $(@)
      if e.attr("disabled") then e.enable() else e.disable()