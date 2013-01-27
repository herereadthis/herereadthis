// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, ResizeFu, checkScroll, em, exports, gVars, makeItHappen, makeMinHeight, moduleName, _window;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    ResizeFu = require("resize_fu");
    exports = {};
    gVars = {
      fade: {
        low: 0.15,
        high: 0.61803
      },
      fadebarID: "ps_fadebar",
      fadebar: "#ps_fadebar",
      h2: {
        ml1: -550,
        ml2: 410
      }
    };
    moduleName = "photo_spice";
    em = parseInt($("body").css("font-size"), 10);
    _window = $(window);
    checkScroll = function(_this) {
      var gRange, getRGB, inverseOp, offset, opacity, pc, place, range, rgb, _h2;
      offset = _this.offset();
      place = Math.round(_this.height() + offset.top - _window.scrollTop());
      if (place > 0) {
        pc = (_window.height() - offset.top + _window.scrollTop()) / _window.height();
        _h2 = _this.find("h2");
        if (pc <= gVars.fade.low) {
          $(gVars.fadebar).css("opacity", 1);
          return _h2.css({
            "opacity": 0,
            "color": "#000"
          });
        } else if (pc < gVars.fade.high) {
          opacity = Math.round(100 * (1 - ((pc - gVars.fade.low) / (gVars.fade.high - gVars.fade.low)))) / 100;
          getRGB = Math.round((1 - opacity) * 255);
          rgb = "rgb(" + getRGB + "," + getRGB + "," + getRGB + ")";
          $(gVars.fadebar).css("opacity", opacity);
          inverseOp = 1 - opacity;
          range = gVars.h2.ml2 - gVars.h2.ml1;
          gRange = ((1 - opacity) * range) + gVars.h2.ml1;
          return _h2.css({
            "opacity": inverseOp,
            "color": rgb
          });
        } else {
          $(gVars.fadebar).css("opacity", 0);
          return _h2.css({
            "opacity": 1,
            "color": "#FFF"
          });
        }
      }
    };
    makeMinHeight = function(_this) {
      var minHeight, _section;
      minHeight = parseInt(_this.css("min-height"), 10) / em;
      _section = _this.find("section");
      return _section.css({
        "min-height": "" + minHeight + "em"
      });
    };
    makeItHappen = function(_this) {
      ResizeFu.init(_this);
      console.log("made it happen for photo_spice");
      makeMinHeight(_this);
      _this.append($("<span />").attr("id", gVars.fadebarID));
      _window.scroll(function() {
        return checkScroll(_this);
      });
      return _window.resize(function() {
        return makeMinHeight(_this);
      });
    };
    exports.init = function(_this) {
      var element;
      if (_this !== void 0) {
        return makeItHappen(_this);
      } else {
        element = $("body").find("[data-module=\"" + moduleName + "\"]");
        return element.each(function() {
          return makeItHappen($(this));
        });
      }
    };
    return exports;
  });

}).call(this);
