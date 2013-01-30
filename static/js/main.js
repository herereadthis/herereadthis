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
      PhotoSpice: "photo_spice",
      Coding: "coding",
      MakeItNew: "make_it_new",
      ResizeFu: "resize_fu",
      NextArrow: "next_arrow",
      Analytics: "analytics",
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


  require(["jquery", 'Modernizr', 'Backbone', 'HeadMore', "PhotoSpice", "Coding", "MakeItNew", 'Analytics'], function($, Modernizr, Backbone, HeadMore, PhotoSpice, Coding, MakeItNew, Analytics) {
    if (Modernizr.touch === false) {
      HeadMore.init();
      PhotoSpice.init();
      MakeItNew.init();
    }
    Coding.init();
    return Analytics.track('UA-37798496-1');
  });

  /*
                                               ,gg,
                                 +@@@,      ;#@@@@@@p
                                d@@@#      :@@@'  @@@+
                              _g@@@'      ;@@@    ;@@@
                         _d@@@@@@@@      .@@@     '@@/
                      :@@@@P*' #@@+      @@@'
                    ,@@@;      @@@;     ;@@#
                    @@@`      :@@@      @@@.           A.
                    @@@       @@@+     :@@@           `@@@
                    @@@@+:,  ,@@@;     @@@:           ;@@@
                     \@@@@:  ;@@@     ;@@@      g#g.  '@@*        g##p
                       ":'   @@@*     +@@P    #@@@@@, ,@@       .@@@@@@
             _,aa,_          @@@;     @@@:  /@@@' @@|  @@@L    ;@@+ `@@}
          g@@@@@@@@@p    /@@@@@@@@@@@@@@@   @@@  ,@@  ,@@@@.   ;@@"  +@@
        g@@@P     `@@@  :@@@@@@@@@@@@@@@}  ;@@; :@@;  #'.@@@   @@@  +@@`
       @@@P        `@@}    `@@@#     @@@}  @@@:@@@'  .@ ;@@@  .@@@;@@+   a
      @@@P         ,@@@    ;@@@'    :@@@' {@@@+,     #: '@@:  ;@@@P*    |@`
     g@@#          :@@@    @@@@     ;@@@  {@@@      ;@  @@@  +@@@L     d@*
     @@@'         ,@@@}   :@@@:     #@@@   @@@.    #@' '@@, ;@:@@@    d@P
    {@@@         {@@@@    @@@@      @@@}   q@@@+;#@@"  @@@;#@* @@@@';@@@
    {@@@           `@*   '@@@P     .@@@:    @@@@@@@"   +@@@@*  *@@@@@@*
     @@@.               .@@@P      +@@@'     `"""'      `""      `""'
     ?@@+              .@@@#       @@@@
      @@@:            ,@@@+       ,@@@@
       #@@#         /#@@@'        ;@@@+
       `@@@@+;==;#@@@@P          #@@@W
         `*\@@@@@@@@/            `***
  */


}).call(this);
