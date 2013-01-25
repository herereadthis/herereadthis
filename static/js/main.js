// Generated by CoffeeScript 1.3.3

/*
                    '.       
        .-""-._     \ \.--|  
       /       "-..__) .-'   
     ಠ_______ಠ        /     
      \'-.__,   .__.,'       
       `'----'._\--'  
     Whale whale whale, what have we here?
*/


(function() {

  requirejs.config({
    baseUrl: "/static/js/",
    shim: {
      "maya_stripes": ["jquery"],
      "code_tango": ["jquery"],
      "accordian_player": ["jquery"],
      "Modernizr": {
        deps: ["jquery"],
        exports: "Modernizr"
      },
      'Backbone': {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      },
      'underscore': {
        exports: '_'
      }
    },
    paths: {
      main: "main",
      HeadMore: "head_more",
      Coding: "coding",
      ResizeFu: "resize_fu",
      CanvasSally: "canvas_sally",
      jquery: "library/jquery.1.9.0.min",
      Modernizr: "library/modernizr_custom",
      Backbone: "library/backbone-min",
      underscore: "library/underscore-min"
    }
  });

  /*
  require ["jquery", "maya_stripes", "accordian_player"], ($) ->
      $ () ->
          _banner = $("html.no-touch").find('[role="banner"]')
          _main = $("html.no-touch").find('[role="main"]')
          if _banner != undefined and _main != undefined
              _banner.mayaStripes
                  "complement": _main
                  "clearance": true
              _main.mayaStripes
                  "complement": _banner
                  "clearance": false
          _article = $("html.touch").find("article")
          if _article.html() != undefined
              _article.accordianPlayer()
  */


  require(["jquery", 'HeadMore', "Coding", 'CanvasSally', 'Modernizr', 'Backbone', 'Analytics'], function($, HeadMore, Coding, CanvasSally, Modernizr, Backbone, Analytics) {
    if (Modernizr.touch === false) {
      HeadMore.init();
      CanvasSally.init();
      Coding.init();
    }
    return Analytics.track('UA-37798496-1');
  });

  /*
                                               ,;;,
                                 +@@@,      ;#@@@@@@#
                                d@@@#      :@@@'  @@@+
                               g@@@'      ;@@@    ;@@@
                         _d@@@@@@@@      .@@@     '@@/
                      :@@@@P*' #@@+      @@@'
                    `@@@;      @@@;     ;@@#
                    @@@`      :@@@      @@@.           A.
                    @@@       @@@+     :@@@           `@@@
                    @@@@+:,  `@@@;     @@@:           ;@@@
                     \@@@@:  ;@@@     ;@@@______:';`  '@@+_________`;':
                       ":'   @@@#     +@@P    #@@@@@, ,@@.       .@@@@@@
              ,aa,          `@@@;     @@@:  /@@@' @@'  @@@;     ;@@+ `@@`
          g@@@@@@@@@p    /@@@@@@@@@@@@@@@   @@@  ,@@. ,@@@@.   ;@@#  +@@
        g@@@P     ,@@@  :@@@@@@@@@@@@@@@;  ;@@; :@@;  #'.@@@   @@@` +@@`
       @@@P________,@@'    `@@@#     @@@'  @@@:@@@'  .@ ;@@@  ;@@@;@@+   ~
      @@@P_________`@@@    ;@@@'    :@@@. `@@@+,     #: '@@:  @@@@'.____`@`
     g@@#__________:@@@    @@@@     ;@@@  `@@@      ;@  @@@  +@@@+______@
     @@@`_________`@@@}   :@@@:     #@@@   @@@.    #@' '@@, ;@:@@@____`@P
    |@@@_________`@@@@    @@@@      @@@+   q@@@+;#@@.  @@@;#@,_@@@@';@@@
    |@@@___________+@`   '@@@P     .@@@:    @@@@@@@/   +@@@@,__.@@@@@@+
     @@@`               .@@@P      +@@@`     `::,_______`.`______.::.
     ?@@+______________.@@@#       @@@@
      @@@:____________,@@@+_______`@@@@
       #@@#         /#@@@'________;@@@+
       `@@@@+;==;#@@@@P__________#@@@W
         `*\@@@@@@@@/            `***
  */


}).call(this);
