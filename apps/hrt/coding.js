// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, ResizeFu, cVars, code_tango, exports, gVars, makeIndex, makeItHappen, moduleName, rileyGo, scrollTitle, _window;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    ResizeFu = require("resize_fu");
    exports = {};
    gVars = {};
    moduleName = "coding";
    _window = $(window);
    cVars = {
      preClass: "code_tango",
      preParent: "blockquote",
      idealWidth: 108,
      bgWidth: 192,
      pc: 0.2,
      barWidth: 1,
      pLeftThreshold: 1.5,
      horbarSize: 2,
      horFactor: 2,
      sidePad: 5,
      rileyColors: ["0e90d2", "c96977", "3f8be6", "cea635", "0b90d7", "cb6573", "0b91d6", "cb6676", "23293d", "d0a62e", "0e8fd6", "cb6371", "408ae9", "c96474", "dfe7f4", "0d90d7", "ca6774", "3a8be6", "cfa632", "0b91d7", "cea834", "198fc8", "142c47", "d2a631", "3e8de7", "e5ecf7", "cc6874", "0c95d7", "cf6671", "172945", "3b8ce6", "d2a831", "0c8fd7", "ca6571", "0b8eda", "e2eefb", "398ce9", "1092d5", "cc6670", "0d94db", "d5a730", "3d8deb", "152942", "0d91d9", "cc6571", "428aeb", "d4a834", "3f8de9", "ecf0f7", "d3a933", "3e8dec", "d5a932", "3e8cec", "d06674", "1a2844", "3e8cee", "d4ab34", "3c8fee", "0b95dc", "d7aa33", "0b94dc", "f0f1f6", "d6aa35", "3e8feb", "d16772", "0c91dc", "1a283b", "d8ab31", "0a97dc", "d7ab32", "f3f3f6", "d36770", "3c8feb", "202b3d", "d1ad3c", "4590ea", "d7ab32", "d36974", "0c94d3", "d8aa34", "0d94db", "f1f4f3", "d7ad31", "0d98dc", "d7ad34", "4692ec", "d56875", "242e3e", "d6ae33", "0a9ce0", "d7af34", "4a94f0", "d26d78", "4894ef", "0a98dc", "eef5f7", "0b98dc", "daae35", "3c96ea", "0b98dd", "d16e7c", "4294ec", "1d2d4a", "d56c7c", "4495ee", "dbb03d", "4796ea", "0e99e3", "309bf0"],
      em: parseInt($("body").css("font-size"), 10),
      titleThreshold: 1040
    };
    rileyGo = function(_this, lVars) {
      var barStart, beyondView, bgi1, bgi2, bgi3, bgs1, bgs2, bgs3, canvas, canvas2, canvas3, color, context, context2, context3, horBarStartWidth, horBarVert, horBars, i, pRight, rVars, titleWidth, widthPlusPad, _i, _j, _k, _len, _len1, _len2, _ref, _title;
      rVars = {
        cWidth: lVars.bgWidth * cVars.em,
        cHeight: 100,
        pc: lVars.pc,
        ideal: lVars.idealWidth * cVars.em,
        start: 0,
        increment: lVars.barWidth * cVars.em,
        pLeft: parseInt(_this.find("section").css("padding-left"), 10),
        pLeftThreshold: lVars.pLeftThreshold * cVars.em,
        horbarSize: lVars.horbarSize,
        horFactor: lVars.horFactor
      };
      rVars.start = rVars.ideal - (rVars.ideal * rVars.pc) + ((rVars.cWidth - rVars.ideal) / 2);
      rVars.docIdealWidth = rVars.ideal + 2 * lVars.sidePad * cVars.em;
      rVars.adjustedWidth = rVars.ideal - rVars.pc * rVars.ideal - rVars.pLeftThreshold;
      canvas = document.createElement("canvas");
      canvas.width = rVars.cWidth;
      canvas.height = rVars.cHeight;
      context = canvas.getContext("2d");
      barStart = rVars.start;
      _ref = cVars.rileyColors;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        i = _ref[_i];
        color = "#" + i;
        context.fillStyle = color;
        context.fillRect(barStart, 0, rVars.increment, rVars.cHeight);
        barStart += rVars.increment;
      }
      horBars = cVars.rileyColors.slice(0, rVars.horbarSize);
      canvas2 = document.createElement("canvas");
      canvas2.width = rVars.cWidth;
      canvas2.height = horBars.length * rVars.increment * rVars.horFactor;
      context2 = canvas2.getContext("2d");
      horBarStartWidth = rVars.start;
      horBarVert = rVars.increment * (horBars.length - 1) * rVars.horFactor;
      for (_j = 0, _len1 = horBars.length; _j < _len1; _j++) {
        i = horBars[_j];
        color = "#" + i;
        context2.fillStyle = color;
        context2.fillRect(0, horBarVert, horBarStartWidth, rVars.increment * rVars.horFactor);
        horBarVert -= rVars.increment * rVars.horFactor;
        horBarStartWidth += rVars.increment;
      }
      canvas3 = document.createElement("canvas");
      canvas3.width = rVars.cWidth;
      canvas3.height = horBars.length * rVars.increment * rVars.horFactor;
      context3 = canvas3.getContext("2d");
      horBarStartWidth = rVars.start;
      horBarVert = 0;
      for (_k = 0, _len2 = horBars.length; _k < _len2; _k++) {
        i = horBars[_k];
        color = "#" + i;
        context3.fillStyle = color;
        context3.fillRect(0, horBarVert, horBarStartWidth, rVars.increment * rVars.horFactor);
        horBarVert += rVars.increment * rVars.horFactor;
        horBarStartWidth += rVars.increment;
      }
      bgi1 = "url(" + (canvas2.toDataURL("image/png")) + ")";
      bgi2 = "url(" + (canvas3.toDataURL("image/png")) + ")";
      bgi3 = "url(" + (canvas.toDataURL("image/png")) + ")";
      bgs1 = "" + canvas.width + "px " + canvas2.height + "px";
      bgs2 = "" + canvas.width + "px " + canvas3.height + "px";
      bgs3 = "" + canvas.width + "px 100px";
      _this.css({
        "background-image": "" + bgi1 + "," + bgi2 + "," + bgi3,
        "background-size": "" + bgs1 + "," + bgs2 + "," + bgs3,
        "background-position": "50% 0%, 50% 100%, 50% 50%",
        "background-repeat": "no-repeat, no-repeat,repeat"
      });
      _title = _this.find("h2");
      if (_window.width() >= rVars.docIdealWidth) {
        titleWidth = rVars.pc * rVars.ideal + rVars.pLeft;
        _this.children().css({
          "padding-right": titleWidth + rVars.pLeftThreshold,
          "width": rVars.adjustedWidth
        });
      } else {
        widthPlusPad = _window.width();
        beyondView = (rVars.cWidth - widthPlusPad) / 2;
        titleWidth = (rVars.cWidth - rVars.start) - beyondView;
        pRight = titleWidth + rVars.pLeftThreshold;
        _this.children().css({
          "padding-right": pRight,
          "padding-left": "",
          "width": "auto"
        });
      }
      if (Modernizr.touch === true) {
        return _this.children().css({
          "width": "auto"
        });
      } else {
        if (_window.width() > cVars.titleThreshold) {
          return _title.css({
            "width": titleWidth,
            "height": titleWidth,
            "line-height": "" + titleWidth + "px"
          });
        } else {
          return _title.css({
            "width": "",
            "height": "",
            "line-height": ""
          });
        }
      }
    };
    scrollTitle = function(_this) {
      var distance, offset, place, range, showing, theory, titleHeight, topPad, _title;
      if (_window.width() > cVars.titleThreshold) {
        offset = _this.offset();
        place = Math.round(_this.outerHeight() + offset.top - _window.scrollTop());
        if (_window.scrollTop() + _window.outerHeight() >= offset.top && place > 0) {
          showing = _window.scrollTop() + _window.height() - offset.top;
          _title = _this.find("h2");
          titleHeight = _title.height();
          topPad = parseFloat(_this.css("padding-top"), 10);
          if (showing <= titleHeight) {
            return _title.css({
              "top": -1 * topPad
            });
          } else if (place - titleHeight >= 0) {
            range = _this.outerHeight() - titleHeight;
            distance = _window.height() + _this.outerHeight() - 2 * titleHeight;
            theory = (showing - titleHeight) / distance;
            return _title.css({
              "top": range * theory - topPad
            });
          } else {
            return _title.css({
              "top": _this.outerHeight() - titleHeight - topPad
            });
          }
        }
      }
    };
    makeIndex = function(_this, lineCount) {
      var i, iLength, indices, j, maxIndex, _i, _j, _k, _len, _len1, _len2, _results;
      indices = [];
      indices.length = lineCount;
      for (j = _i = 0, _len = indices.length; _i < _len; j = ++_i) {
        i = indices[j];
        indices[j] = "" + (j + 1) + ".";
      }
      maxIndex = indices[lineCount - 1].length;
      for (j = _j = 0, _len1 = indices.length; _j < _len1; j = ++_j) {
        i = indices[j];
        iLength = i.length;
        while (iLength < maxIndex) {
          indices[j] = " " + i;
          iLength++;
        }
      }
      _this.closest("div").before($("<div />").addClass("code_copy").html($("<pre />")));
      _results = [];
      for (j = _k = 0, _len2 = indices.length; _k < _len2; j = ++_k) {
        i = indices[j];
        indices[j] = "<span>" + i + "</span>";
        _this.closest("div").prev().find("pre").append(indices[j]);
        if (j < lineCount) {
          _results.push(_this.closest("div").prev().find("pre").append("\n"));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    code_tango = function(_this) {
      var i, indexWidth, j, lineCount, snippet, _code, _div, _i, _len;
      _this.closest(cVars.preParent).addClass(cVars.preClass);
      _this.wrap('<div class="code_container" />');
      _this.wrap('<div class="code_copy" />');
      _code = _this.find("code");
      snippet = _code.html().split("\n");
      _code.empty();
      lineCount = snippet.length;
      for (j = _i = 0, _len = snippet.length; _i < _len; j = ++_i) {
        i = snippet[j];
        snippet[j] = "<span>" + i + "</span>";
        _code.append(snippet[j]);
        if (j < lineCount) {
          _code.append("\n");
        }
      }
      makeIndex(_this, lineCount);
      _div = _this.parent("div");
      indexWidth = _div.prev("div").outerWidth(false);
      return _this.closest(cVars.preParent).css({
        "background-size": "" + indexWidth + "px 100%"
      });
    };
    makeItHappen = function(_this) {
      var i, lVars, pres, thisData, _body, _i, _len;
      _body = $("body");
      thisData = {};
      if (_this.data("coding-bgwidth") !== void 0) {
        thisData.bgWidth = parseInt(_this.data("coding-bgwidth"), 10);
      }
      if (_this.data("coding-pc") !== void 0) {
        thisData.pc = parseInt(_this.data("coding-pc") * 100, 10) / 100;
      }
      if (_this.data("coding-bar-width") !== void 0) {
        thisData.barWidth = parseInt(_this.data("coding-bar-width") * 100, 10) / 100;
      }
      if (_this.data("coding-pleft-threshold") !== void 0) {
        thisData.pLeftThreshold = parseInt(_this.data("coding-pleft-threshold") * 100, 10) / 100;
      }
      if (_this.data("coding-horbar-size") !== void 0) {
        thisData.horbarSize = parseInt(_this.data("coding-horbar-size"), 10);
      }
      if (_this.data("coding-horfactor") !== void 0) {
        thisData.horFactor = parseInt(_this.data("coding-horfactor") * 100, 10) / 100;
      }
      if (_body.data("resizefu-ideal-width") !== void 0) {
        thisData.idealWidth = parseInt(_body.data("resizefu-ideal-width"), 10);
      }
      if (_body.data("resizefu-side-pad") !== void 0) {
        thisData.sidePad = parseInt(_body.data("resizefu-side-pad"), 10);
      }
      lVars = {};
      lVars.pc = thisData.pc != null ? thisData.pc : cVars.pc;
      lVars.bgWidth = thisData.bgWidth != null ? thisData.bgWidth : cVars.bgWidth;
      lVars.barWidth = thisData.barWidth != null ? thisData.barWidth : cVars.barWidth;
      lVars.pLeftThreshold = thisData.pLeftThreshold != null ? thisData.pLeftThreshold : cVars.pLeftThreshold;
      lVars.horbarSize = thisData.horbarSize != null ? thisData.horbarSize : cVars.horbarSize;
      lVars.horFactor = thisData.horFactor != null ? thisData.horFactor : cVars.horFactor;
      lVars.idealWidth = thisData.idealWidth != null ? thisData.idealWidth : cVars.bgWidth;
      lVars.sidePad = thisData.sidePad != null ? thisData.sidePad : cVars.sidePad;
      rileyGo(_this, lVars);
      pres = _this.find("pre");
      for (_i = 0, _len = pres.length; _i < _len; _i++) {
        i = pres[_i];
        code_tango($(i));
      }
      if (Modernizr.touch === false) {
        ResizeFu.init(_this);
        scrollTitle(_this);
      }
      _window.resize(function() {
        return rileyGo(_this, lVars);
      });
      return _window.scroll(function() {
        if (Modernizr.touch === false) {
          return scrollTitle(_this);
        }
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
