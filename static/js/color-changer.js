define(["jquery"], function($) {
  var exports = {},
      colors = ['red', 'blue', 'yellow', 'green', 'orange', 'purple'],
      getRandomColor = function() {
        var max = colors.length,
            index = Math.floor(Math.random()*max+1);
        return colors[index];
      };

  exports.init = function(element) {
    var previousColor;
    element.click(function() {
      var color;
      while (!color || color === previousColor) {
        color = getRandomColor();
      }
      element.css('background', color);
      previousColor = color;
    });
  };

  return exports;
});