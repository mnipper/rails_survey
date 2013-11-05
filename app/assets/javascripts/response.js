$(function(){

    //Backbone Model
    window.Response = Backbone.Model.extend({
        url: function(){

        }

        initialize: function(){

        }
    });

    //Backbone View
    window.ResponseCollection = Backbone.Collection.extend({
        model: Response,
        url: '/responses'

        initialize: function(){
            window.on('responses', this.handle_change, this);
        },

        handle_change : function(message){
            var model;

            switch(message.action){
                case 'create':
                    this.add(message.obj);
                    break;
                case 'update':
                    model = this.get(message.id);
                    model.set(message.obj);
                    break;
                case 'destroy':
                    this.remove(message.obj);
            }
        }
    });
    window.Response = new ResponseCollection;

})