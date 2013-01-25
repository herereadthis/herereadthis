# http://paceyourself.net/js/util/analytics.js
define (require) ->
	# $ = require "jquery"
	exports = 
		track: ( accountId ) ->
			_gaq = window._gaq = _gaq or []
			ga = document.createElement "script"
			s = document.getElementsByTagName('script')[0]

			_gaq.push ['_setAccount', accountId]
			_gaq.push ['_trackPageview']
			
			ga.type = "text/javascript"
			ga.async = true

			secure = "https://ssl.google-analytics.com/ga.js"
			unsecure = "http://www.google-analytics.com/ga.js"
			ga.src = (if 'https:' is document.location.protocol then 'https://ssl' else 'http://www') + ".google-analytics.com/ga.js"
			console.log ga.src, "!"

			window.onload = () ->
				s.parentNode.insertBefore ga, s
				# $("head").append $("<script />").attr
				# 	"type": "text/javascript"
				# 	"async": true
				# 	"src": if 'https:' is document.location.protocol then secure else unsecure
				console.log "analytics init"

	exports
###
 var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-37798496-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
###
###
// http://paceyourself.net/js/util/analytics.js
define(function(){
    var exports = {
      track: function(accountId) {
        var _gaq = window._gaq = _gaq || [],
            ga = document.createElement('script'),
            s = document.getElementsByTagName('script')[0];

        _gaq.push(['_setAccount', accountId]);
        _gaq.push(['_trackPageview']);

        ga.type = 'text/javascript';
        ga.async = true;
        ga.src = ('https:' == document.location.protocol ?
          'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';

        s.parentNode.insertBefore(ga, s);
        console.log("analytics init");
      }
    };

  return exports;
});

###