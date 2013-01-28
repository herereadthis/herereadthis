// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, NextArrow, ResizeFu, em, exports, gVars, makeItHappen, makeSocialClick, moduleName;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    NextArrow = require("next_arrow");
    ResizeFu = require("resize_fu");
    NextArrow = require("next_arrow");
    exports = {};
    gVars = {};
    moduleName = "head_more";
    em = parseInt($("body").css("font-size"), 10);
    makeSocialClick = function(_this) {
      return _this.on("click", "li", function(e) {
        var href, _links;
        _links = $(this).find("a");
        if (_links.length === 1) {
          href = _links.attr("href");
          return window.location.href = href;
        }
      });
    };
    makeItHappen = function(_this) {
      ResizeFu.init(_this);
      makeSocialClick(_this.find("aside"));
      return NextArrow.init(_this);
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
