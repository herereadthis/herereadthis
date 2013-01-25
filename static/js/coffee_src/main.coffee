
###
                    '.       
        .-""-._     \ \.--|  
       /       "-..__) .-'   
     ಠ_______ಠ        /     
      \'-.__,   .__.,'       
       `'----'._\--'  
     Whale whale whale, what have we here?
###



# target only safari: http://stackoverflow.com/questions/6849086/
# if navigator.userAgent.indexOf('Safari') is not -1 and navigator.userAgent.indexOf('Chrome') is -1
# if (navigator.userAgent.indexOf('Safari') != -1 && navigator.userAgent.indexOf('Chrome') == -1)

# using RequireJs API
requirejs.config
    # "baseURL" is the root path to use for all module lookups, root is defined as where index.html lives
    baseUrl: "/static/js/"
    shim:
        "maya_stripes": ["jquery"]
        "code_tango": ["jquery"]
        "accordian_player": ["jquery"]
        "Modernizr":
            deps: ["jquery"]
            exports: "Modernizr"
        'Backbone': 
            deps: [ 'jquery', 'underscore']
            exports: 'Backbone'
        'underscore':
            exports: '_'

    # "paths" are path mappings for module names not found directly under baseUrl
    paths:
        main: "main"
        jquery: "library/jquery.1.9.0.min"
        Modernizr: "library/modernizr_custom"
        # backbone tutorials:
        # http://backbonetutorials.com
        # http://www.joezimjs.com/javascript/introduction-to-backbone-js-part-1-models-video-tutorial/
        Backbone: "library/backbone-min"
        underscore: "library/underscore-min"
        ResizeFu: "resize_fu"



###
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
###

require ["jquery", "code_tango"], ($) ->
    $ () ->
        _pre = $("pre")
        _pre.codeTango()

# require ["jquery", "widerFatter"], (widerFatter) ->
#     $ () ->
#         $("#beautiful").widerFatter
#             "message": "noped out"
#         # $("#beautiful").widerFatter
#             # "message": "noped out"


# module jack inspired from http://paceyourself.net/2011/05/14/managing-client-side-javascript-with-requirejs/
require [
    "jquery",
    'Modernizr',
    'module_jack', 'Backbone', 'analytics'], ($, Modernizr, moduleJack, Backbone, analytics) ->
    moduleJack.execute()
    analytics.track('UA-37798496-1')





###
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
                                                                           
###
# more asci coding: http://stackoverflow.com/questions/2701192/ascii-character-for-up-down-triangle-arrow-to-display-in-html



