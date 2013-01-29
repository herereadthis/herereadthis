// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, ResizeFu, em, exports, gVars, idealWidth, makeItHappen, moduleClass, moduleName, positionMe, scrollMe, _window;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    ResizeFu = require("resize_fu");
    exports = {};
    gVars = {};
    moduleName = "next_arrow";
    moduleClass = ".next_arrow";
    _window = $(window);
    idealWidth = $("body").data("resizefu-ideal-width");
    em = parseInt($("body").css("font-size"), 10);
    gVars = {
      tol: {
        high: 50,
        low: 15
      },
      scrollSpeed: 1
    };
    scrollMe = function(_this, _arrow) {
      var opacity, pc;
      if (_this.outerHeight() - _window.scrollTop() > 0) {
        pc = (_this.outerHeight() - _window.scrollTop()) / _this.outerHeight();
        if (pc > gVars.tol.high / 100) {
          return _arrow.css({
            "opacity": 1
          });
        } else if (pc > gVars.tol.low / 100) {
          opacity = Math.round((pc * 100 - gVars.tol.low) / (gVars.tol.high - gVars.tol.low) * 100) / 100;
          return _arrow.css({
            "opacity": opacity
          });
        } else {
          return _arrow.css({
            "opacity": 0
          });
        }
      }
    };
    positionMe = function(_this, _arrow) {
      var bottom, horLoc, thisHt, winHt;
      horLoc = (_this.data("nextarrow-location") / 100) * idealWidth * em;
      thisHt = _this.outerHeight(false);
      winHt = _window.height();
      if (winHt > (thisHt + ResizeFu.getPeekNext(_this) * em)) {
        bottom = 0;
      } else {
        bottom = thisHt - winHt;
      }
      if (_window.height() > thisHt) {
        return _arrow.css({
          "bottom": bottom,
          "left": horLoc
        });
      }
    };
    makeItHappen = function(_this) {
      var href, _arrow;
      href = _this.next().attr("id");
      href = "#/" + href + "/";
      _this.append($("<a />").addClass(moduleName).html("&darr;").attr({
        "href": href
      }));
      _arrow = _this.find(moduleClass);
      positionMe(_this, _arrow);
      scrollMe(_this, _arrow);
      _window.resize(function() {
        return positionMe(_this, _arrow);
      });
      _window.scroll(function() {
        return scrollMe(_this, _arrow);
      });
      return _arrow.on("click", function(e) {
        var aniSpeed, nextOffTop, nextOffset;
        nextOffset = $(this).parent().next().offset();
        nextOffTop = Math.round(nextOffset.top);
        aniSpeed = Math.round((nextOffset.top - _window.scrollTop()) / gVars.scrollSpeed);
        return $("html,body").animate({
          scrollTop: nextOffTop
        }, aniSpeed);
      });
    };
    exports.init = function(_this) {
      return makeItHappen(_this);
    };
    return exports;
  });

}).call(this);
