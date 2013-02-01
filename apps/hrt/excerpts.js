// Generated by CoffeeScript 1.3.3
(function() {

  define(function(require) {
    var $, Modernizr, ResizeFu, expandContract, exports, gVars, makeItHappen, moduleName, _window;
    $ = require("jquery");
    Modernizr = require("Modernizr");
    ResizeFu = require("resize_fu");
    exports = {};
    moduleName = "excerpts";
    _window = $(window);
    gVars = {
      ec: {
        showLength: 110,
        tail: 30,
        cutClassName: "cut_after",
        cutClass: "",
        hellipClassName: "cut_hellip",
        hellipClass: "",
        hellip: " [&hellip;] ",
        textShowClassName: "cut_show",
        textShowClass: "",
        moreText: "Show full excerpt &raquo;",
        lessText: "&laquo; Hide text",
        container: "blockquote"
      }
    };
    expandContract = function(_this, lVars) {
      var copy, cutoff, delimiter, i, j, k, paraSlice, str1, str1Array, str2, str2Array, targetPara, textArray, tokens, total, wordCount, _container, _i, _j, _len, _len1, _target;
      copy = _this.find("p");
      textArray = [];
      for (j = _i = 0, _len = copy.length; _i < _len; j = ++_i) {
        i = copy[j];
        textArray[j] = ($(i).html().match(/\S+\s*/g) || []).length;
      }
      total = 0;
      for (_j = 0, _len1 = textArray.length; _j < _len1; _j++) {
        k = textArray[_j];
        total += k;
      }
      _container = _this.closest(lVars.ec.container);
      if (total > lVars.ec.showLength + lVars.ec.tail) {
        wordCount = 0;
        paraSlice = 0;
        while (wordCount < lVars.ec.showLength) {
          if (wordCount + textArray[paraSlice] < lVars.ec.showLength) {
            wordCount += textArray[paraSlice];
          } else {
            break;
          }
          paraSlice++;
        }
        cutoff = lVars.ec.showLength - wordCount;
        _target = $(copy[paraSlice]);
        targetPara = _target.html();
        delimiter = " ";
        tokens = targetPara.split(delimiter);
        str1Array = tokens.slice(0, cutoff - 1);
        str1 = str1Array.join(delimiter);
        str2Array = tokens.slice(cutoff - 1);
        str2 = str2Array.join(delimiter);
        _target.addClass(gVars.ec.cutClassName).html($("<span />").addClass(gVars.ec.cutClassName).html(str1));
        _target.append(" ").append($("<span />").html(str2));
        _target.append($("<span />").addClass(gVars.ec.hellipClassName).html(gVars.ec.hellip));
        _target.append($("<a />").addClass(gVars.ec.textShowClassName).html(gVars.ec.moreText).attr({
          "href": "#"
        }));
        $(copy[copy.length - 1]).append($("<br />")).append($("<a />").addClass(gVars.ec.textShowClassName).attr({
          "href": "#"
        }).html(gVars.ec.lessText));
        _container.attr({
          "aria-expanded": false
        });
      } else {
        _container.attr({
          "aria-expanded": true
        });
      }
      return _this.on("click", gVars.ec.textShowClass, function(e) {
        var ariaState;
        e.preventDefault();
        ariaState = _this.attr("aria-expanded");
        if (_this.attr("aria-expanded") === "false") {
          return _this.attr("aria-expanded", true);
        } else {
          return _this.attr("aria-expanded", false);
        }
      });
    };
    makeItHappen = function(_this) {
      var i, lVars, thisData, _container, _i, _len;
      gVars.ec.cutClass = "." + gVars.ec.cutClassName;
      gVars.ec.hellipClass = "." + gVars.ec.hellipClassName;
      gVars.ec.textShowClass = "." + gVars.ec.textShowClassName;
      thisData = {};
      if (_this.data("excerpts-ec-show-length") !== void 0) {
        thisData.ecShowLength = parseInt(_this.data("excerpts-ec-show-length"), 10);
      }
      if (_this.data("excerpts-ec-tail") !== void 0) {
        thisData.ecTail = parseInt(_this.data("excerpts-ec-tail"), 10);
      }
      if (_this.data("excerpts-ec-more-text") !== void 0) {
        thisData.ecMoreText = _this.data("excerpts-ec-more-text");
      }
      if (_this.data("excerpts-ec-less-text") !== void 0) {
        thisData.ecLessText = _this.data("excerpts-ec-less-text");
      }
      if (_this.data("excerpts-ec-container") !== void 0) {
        thisData.ecContainer = _this.data("excerpts-ec-container");
      }
      lVars = {};
      lVars.ec = {};
      lVars.ec.showLength = thisData.ecShowLength != null ? thisData.ecShowLength : gVars.ec.showLength;
      lVars.ec.tail = thisData.ecTail != null ? thisData.ecTail : gVars.ec.tail;
      lVars.ec.moreText = thisData.ecMoreText != null ? thisData.ecMoreText : gVars.ec.moreText;
      lVars.ec.lessText = thisData.ecLessText != null ? thisData.ecLessText : gVars.ec.lessText;
      lVars.ec.container = thisData.ecContainer != null ? thisData.ecContainer : gVars.ec.container;
      _container = _this.find(lVars.ec.container);
      for (_i = 0, _len = _container.length; _i < _len; _i++) {
        i = _container[_i];
        expandContract($(i), lVars);
      }
      if (Modernizr.touch === false) {
        return ResizeFu.init(_this);
      }
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