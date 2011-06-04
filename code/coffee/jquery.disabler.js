(function() {
  var $;
  $ = jQuery;
  $.extend($.fn, {
    enable: function() {
      return this.each(function() {
        var e;
        e = $(this);
        if (e.is("button") || e.is("input")) {
          return e.attr("disabled", false);
        }
      });
    }
  });
  $.fn.disable = function() {
    return this.each(function() {
      var e;
      e = $(this);
      if (e.is("button") || e.is("input")) {
        return e.attr("disabled", true);
      }
    });
  };
  (function($) {
    if ($ == null) {
      $ = jQuery;
    }
    return $.fn.toggle_enable = function() {
      return this.each(function() {
        var e;
        e = $(this);
        if (e.attr("disabled")) {
          return e.enable();
        } else {
          return e.disable();
        }
      });
    };
  })($);
}).call(this);
