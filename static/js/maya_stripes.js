// Generated by CoffeeScript 1.3.3
(function() {

  (function(jQuery) {
    var $, gVars, methods, settings;
    $ = jQuery;
    settings = {
      variableName: true,
      message: "hello world!",
      complement: {},
      clearance: false,
      barHt: 1000,
      pageWidth: 108,
      padThreshold: 2,
      maya: "maya_stripes"
    };
    gVars = {
      phi: 1.618,
      barDim: [],
      em: 0,
      maya: ""
    };
    methods = {
      init: function(options) {
        return this.each(function() {
          var $this, roundedDim;
          $.extend(settings, options);
          $this = $(this);
          $this.addClass(settings.maya);
          gVars.phi = (1 + Math.sqrt(5)) / 2 - 1;
          gVars.em = parseInt($("html").css("font-size"), 10);
          gVars.maya = "." + settings.maya;
          roundedDim = methods.makeBarDim($this);
          methods.makeMayaCSS($this, roundedDim);
          methods.makeMayaPad($this, roundedDim);
          return $(window).resize(function() {
            return methods.makeMayaPad($this, roundedDim);
          });
        });
      },
      arraySortMin: function(array) {
        var min;
        min = Math.min.apply(Math, array);
        return min;
      },
      getPad: function(_this) {
        var _thisPad;
        _thisPad = {
          top: parseInt(_this.css("padding-top"), 10) / gVars.em,
          right: parseInt(_this.css("padding-right"), 10) / gVars.em,
          bottom: parseInt(_this.css("padding-bottom"), 10) / gVars.em,
          left: parseInt(_this.css("padding-left"), 10) / gVars.em
        };
        return _thisPad;
      },
      makeMayaPad: function(_this, roundedDim) {
        var adjustedPad, docWidth, i, minVal, rightEdge, rightPadRaw, rightPadRound, stripePos, _i, _len, _thisPad;
        docWidth = $(window).width() / gVars.em;
        stripePos = [];
        for (_i = 0, _len = roundedDim.length; _i < _len; _i++) {
          i = roundedDim[_i];
          stripePos.push(i[1]);
        }
        minVal = methods.arraySortMin(stripePos);
        rightEdge = minVal / gVars.em;
        rightPadRaw = settings.pageWidth - rightEdge;
        rightPadRound = Math.round(rightPadRaw * 100) / 100;
        rightPadRound = rightPadRound >= 0 ? rightPadRound : 0;
        _thisPad = methods.getPad(_this);
        if (settings.pageWidth + _thisPad.right + _thisPad.left <= docWidth) {
          adjustedPad = _this.outerWidth(false) / gVars.em - rightEdge - _thisPad.left + settings.padThreshold;
          adjustedPad = (Math.round(adjustedPad * 100) / 100) * gVars.em;
        } else if (docWidth > rightEdge) {
          adjustedPad = (docWidth - _thisPad.left - rightEdge) * gVars.em;
        } else {
          adjustedPad = _thisPad.left * gVars.em;
        }
        return _this.children().css({
          "padding-right": adjustedPad
        });
      },
      makeBarDim: function(_this) {
        var bar1Width, bar2Width, bar3Width, baselineOffset, i, index, lastArr, leftPad, mayaPhiWidth, mayaRemainder, mayaWidth, roundedDim, row, _i, _j, _len, _len1, _ref;
        mayaWidth = (settings.pageWidth * gVars.em) * (1 - gVars.phi) * (1 - gVars.phi);
        mayaPhiWidth = gVars.phi * mayaWidth;
        bar1Width = gVars.phi * mayaPhiWidth;
        mayaRemainder = mayaPhiWidth - bar1Width;
        bar2Width = gVars.phi * mayaRemainder;
        bar3Width = mayaRemainder - bar2Width;
        leftPad = parseInt(_this.css("padding-left"), 10);
        baselineOffset = settings.pageWidth * gVars.em + leftPad;
        gVars.barDim = [[bar1Width, baselineOffset - mayaWidth], [bar2Width, baselineOffset - mayaWidth + mayaPhiWidth], [bar3Width, baselineOffset - bar3Width]];
        roundedDim = [];
        _ref = gVars.barDim;
        for (index = _i = 0, _len = _ref.length; _i < _len; index = ++_i) {
          row = _ref[index];
          roundedDim[index] = [];
          for (_j = 0, _len1 = row.length; _j < _len1; _j++) {
            i = row[_j];
            roundedDim[index].push(Math.round(i));
          }
        }
        lastArr = roundedDim.length - 1;
        if (roundedDim[lastArr][0] + roundedDim[lastArr][1] - leftPad !== settings.pageWidth * gVars.em + 1) {
          roundedDim[lastArr][1] = settings.pageWidth * gVars.em + leftPad - roundedDim[lastArr][0];
        }
        return roundedDim;
      },
      makeMayaCSS: function(_this, roundedDim) {
        var bgPos, bgPosPair, bgSize, bgSizePair, i, j, mayaPadding, _i, _j, _len, _len1;
        bgSize = "";
        for (j = _i = 0, _len = roundedDim.length; _i < _len; j = ++_i) {
          i = roundedDim[j];
          bgSizePair = "" + i[0] + "px " + settings.barHt + "px";
          if (j !== roundedDim.length - 1) {
            bgSizePair += ", ";
          }
          bgSize += bgSizePair;
        }
        bgPos = "";
        if (settings.clearance === true) {
          mayaPadding = roundedDim[1][0] + roundedDim[2][0];
        } else {
          mayaPadding = 0;
        }
        for (j = _j = 0, _len1 = roundedDim.length; _j < _len1; j = ++_j) {
          i = roundedDim[j];
          bgPosPair = "" + i[1] + "px " + mayaPadding + "px";
          if (j !== roundedDim.length - 1) {
            bgPosPair += ", ";
          }
          bgPos += bgPosPair;
        }
        return _this.css({
          "background-size": bgSize,
          "background-position": bgPos
        });
      }
    };
    return $.fn.mayaStripes = function(method) {
      if (methods[method]) {
        return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
      } else if (typeof method === 'object' || !method) {
        return methods.init.apply(this, arguments);
      } else {
        return $.error('Method ' + method + ' does not exist on jQuery.mayaStripes');
      }
    };
  })(jQuery);

}).call(this);
