// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, exports, gVars, getBrowserDim, getElementDim, makePads, makeResize;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    exports = {};
    gVars = {
      browserWt: 0,
      browserHt: 0,
      idealWidth: 108,
      sidePad: 5,
      em: parseInt($("body").css("font-size"), 10),
      maxRatio: (1 + Math.sqrt(5)) / 2 - 1,
      thresholdTop: 5,
      thresholdBot: 5,
      peekNext: 3
    };
    getBrowserDim = function() {
      gVars.browserWt = $(window).width();
      return gVars.browserHt = $(window).height();
    };
    getElementDim = function(_this) {
      var thisDim;
      _this.css({
        "padding-top": "",
        "padding-bottom": ""
      });
      thisDim = {
        width: _this.width(),
        height: _this.height(),
        outerWt: _this.outerWidth(true),
        outerHt: _this.outerHeight(true),
        padding: {
          top: parseInt(_this.css("padding-top"), 10),
          right: parseInt(_this.css("padding-right"), 10),
          bottom: parseInt(_this.css("padding-bottom"), 10),
          left: parseInt(_this.css("padding-left"), 10)
        }
      };
      return thisDim;
    };
    makePads = function(_this, threshTop, threshBot) {
      threshTop = threshTop || 0;
      threshBot = threshBot || threshTop;
      return _this.css({
        "padding-top": "" + threshTop + "em",
        "padding-bottom": "" + threshBot + "em"
      });
    };
    makeResize = function(_this, thisData, lVars) {
      var botT, subTheoryHeight, theoryThresholds, theoryWidth, thisDim, thresholds, topT;
      getBrowserDim();
      thisDim = getElementDim(_this);
      theoryWidth = (gVars.idealWidth + 2 * gVars.sidePad) * gVars.em;
      if (gVars.browserWt > theoryWidth) {
        if (gVars.browserHt < thisDim.height) {
          return makePads(_this, lVars.thresholdTop, lVars.thresholdBot);
        } else if (((gVars.browserHt - lVars.peekNext * gVars.em) / theoryWidth) > lVars.maxRatio) {
          subTheoryHeight = thisDim.height + (lVars.thresholdTop + lVars.thresholdBot) * gVars.em;
          if (subTheoryHeight < lVars.maxRatio * theoryWidth) {
            if (thisData.thresholdTop === 0 && thisData.thresholdBot === 0) {
              return _this.css({
                "min-height": lVars.maxRatio * theoryWidth
              });
            } else {
              thresholds = (lVars.maxRatio * theoryWidth) - thisDim.height;
              thresholds = (thresholds / 2) / gVars.em;
              return makePads(_this, thresholds);
            }
          } else {
            return makePads(_this, lVars.thresholdTop, lVars.thresholdBot);
          }
        } else {
          if (((gVars.browserHt - thisDim.height) / gVars.em) > (lVars.thresholdTop + lVars.thresholdBot + lVars.peekNext)) {
            if (lVars.thresholdTop === 0 && lVars.thresholdBot === 0) {
              return _this.css({
                "min-height": "" + ((gVars.browserHt / gVars.em) - lVars.peekNext) + "em"
              });
            } else {
              thresholds = ((gVars.browserHt - thisDim.height) / gVars.em) - lVars.peekNext;
              if (thisData.thresholdTop === void 0 && thisData.thresholdBot === void 0) {
                theoryThresholds = thresholds / 2;
                return makePads(_this, thresholds / 2);
              } else if (thisData.thresholdTop !== void 0 && thisData.thresholdBot === void 0) {
                botT = thresholds - thisData.thresholdTop >= 0 ? thresholds - thisData.thresholdTop : 0;
                return makePads(_this, thisData.thresholdTop, botT);
              } else if (thisData.thresholdTop === void 0 && thisData.thresholdBot !== void 0) {
                topT = thresholds - thisData.thresholdBot >= 0 ? thresholds - thisData.thresholdBot : 0;
                return makePads(_this, topT, thisData.thresholdBot);
              } else {
                return makePads(_this, thisData.thresholdTop, thisData.thresholdBot);
              }
            }
          } else {
            return makePads(_this, lVars.thresholdTop, lVars.thresholdBot);
          }
        }
      } else {
        if (lVars.thresholdTop === 0 && lVars.thresholdBot === 0) {
          return _this.css({
            "min-height": "" + ((gVars.browserHt / gVars.em) - lVars.peekNext) + "em"
          });
        } else {
          return makePads(_this, lVars.thresholdTop, lVars.thresholdBot);
        }
      }
    };
    exports.getPeekNext = function(_this) {
      var peekNext, tdPeekNext;
      if (_this.data("resizefu-peek-next") !== void 0) {
        tdPeekNext = parseInt(_this.data("resizefu-peek-next"), 10);
      }
      peekNext = tdPeekNext != null ? tdPeekNext : gVars.peekNext;
      return peekNext;
    };
    exports.init = function(_this) {
      var lVars, settings, thisData, _body;
      settings = {
        var1: "foo"
      };
      _body = $("body");
      thisData = {};
      if (_this.data("resizefu-threshold-top") !== void 0) {
        thisData.thresholdTop = parseInt(_this.data("resizefu-threshold-top"), 10);
      }
      if (_this.data("resizefu-threshold-bottom") !== void 0) {
        thisData.thresholdBot = parseInt(_this.data("resizefu-threshold-bottom"), 10);
      }
      if (_this.data("resizefu-peek-next") !== void 0) {
        thisData.peekNext = parseInt(_this.data("resizefu-peek-next"), 10);
      }
      if (_this.data("resizefu-max-ratio") !== void 0) {
        thisData.maxRatio = parseFloat(_this.data("resizefu-max-ratio"), 10);
      }
      if (_body.data("resizefu-ideal-width") !== void 0) {
        thisData.idealWidth = parseInt(_body.data("resizefu-ideal-width"), 10);
      }
      if (_body.data("resizefu-side-pad") !== void 0) {
        thisData.sidePad = parseInt(_body.data("resizefu-side-pad"), 10);
      }
      lVars = {};
      lVars.thresholdTop = thisData.thresholdTop != null ? thisData.thresholdTop : gVars.thresholdTop;
      lVars.thresholdBot = thisData.thresholdBot != null ? thisData.thresholdBot : gVars.thresholdBot;
      lVars.maxRatio = thisData.maxRatio != null ? thisData.maxRatio : gVars.maxRatio;
      lVars.peekNext = thisData.peekNext != null ? thisData.peekNext : gVars.peekNext;
      lVars.idealWidth = thisData.idealWidth != null ? thisData.idealWidth : gVars.idealWidth;
      lVars.sidePad = thisData.sidePad != null ? thisData.sidePad : gVars.sidePad;
      makeResize(_this, thisData, lVars);
      return $(window).resize(function() {
        return makeResize(_this, thisData, lVars);
      });
    };
    return exports;
  });

}).call(this);
