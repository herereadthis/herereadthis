
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
    # baseUrl: "/static/js/"
    shim:
        "Modernizr":
            deps: ["jquery"]
            exports: "Modernizr"

    # "paths" are path mappings for module names not found directly under baseUrl
    paths:
    # In-House -------------
        # ModuleJack: "module_jack"
        HeadMore: "head_more"
        PhotoSpice: "photo_spice"
        Coding: "coding"
        MakeItNew: "make_it_new"
        Excerpts: "excerpts"
        Footsie: "footsie"
        ResizeFu: "resize_fu"
        NextArrow: "next_arrow"
        "Analytics": "analytics"
    # Libraries ------------
        "jquery": "../../lib/jquery.1.9.0.min"
        "Modernizr": "../../lib/modernizr_custom"


# backbone tutorials:
# http://backbonetutorials.com
# http://www.joezimjs.com/javascript/introduction-to-backbone-js-part-1-models-video-tutorial/

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



# require [
#     "jquery"
#     'Modernizr'
#     'HeadMore', "PhotoSpice", "Coding", "MakeItNew", "Excerpts", "Footsie"
#     'Analytics'], ($, Modernizr, HeadMore, PhotoSpice, Coding, MakeItNew, Excerpts, Footsie, Analytics ) ->
#     # do TestApp.init
#     # do Backbone.history.start
#     # if Modernizr.touch is false
#     #     do HeadMore.init
#     #     do PhotoSpice.init
#     #     do MakeItNew.init
#     # do Coding.init
#     # do Excerpts.init
#     # do Footsie.init
#         # do TestApp.init
#         # do Backbone.history.start
#     Analytics.track('UA-37798496-1')

require ["jquery", "Modernizr",
    'HeadMore', "PhotoSpice", "Coding", "MakeItNew", "Excerpts", "Footsie"
    'Analytics'], ( $, Modernizr, HeadMore, PhotoSpice, Coding, MakeItNew, Excerpts, Footsie, Analytics ) ->
    # do TestApp.init
    # do Backbone.history.start
    if Modernizr.touch is false
        do HeadMore.init
        do PhotoSpice.init
        do MakeItNew.init
    do Coding.init
    do Excerpts.init
    do Footsie.init
        # do TestApp.init
        # do Backbone.history.start
    Analytics.track('UA-37798496-1')



###
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
                                                                           
###
# more asci coding: http://stackoverflow.com/questions/2701192/ascii-character-for-up-down-triangle-arrow-to-display-in-html



