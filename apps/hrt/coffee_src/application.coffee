define ( require ) ->
    Routers = require "./routers"
    Models = require "./models"
    Views = require "./views"
    Templates = require "./templates"

    return {
        init: () ->
            new Routers.Test()
        Models: Models
        Views: Views
        Templates: Templates
    }


###
define(function (require) {
    var Routers = require('./routers');
        Models = require('./models'),
        Views = require('./views');
        Templates = require('./templates');

    return {
        init: function () {
            new Routers.Test();
        },
        Models: Models,
        Views: Views,
        Templates: Templates
    };
});
###