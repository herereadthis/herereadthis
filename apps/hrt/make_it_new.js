// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, ResizeFu, em, exports, gVars, makeItHappen, makeShape, moduleName, _window;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    ResizeFu = require("resize_fu");
    exports = {};
    gVars = {};
    moduleName = "make_it_new";
    em = parseInt($("body").css("font-size"), 10);
    _window = $(window);
    makeShape = function(_this) {
      var bgSize, newBgPos, newBgSize, padBot, padTop, pb, pt;
      pt = _this.css("padding-top").split("px");
      padTop = pt[0];
      pb = _this.css("padding-bottom").split("px");
      padBot = pb[0];
      bgSize = _this.css("background-size").split(" ");
      newBgSize = "" + (parseInt(bgSize[0], 10)) + "% " + (_this.height()) + "px";
      newBgPos = "0% " + (padTop / em) + "em";
      return _this.css({
        "background-size": newBgSize,
        "background-position": newBgPos
      });
    };
    makeItHappen = function(_this) {
      var _section;
      ResizeFu.init(_this);
      _section = _this.find("section");
      makeShape(_this);
      return _window.resize(function() {
        return makeShape(_this);
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