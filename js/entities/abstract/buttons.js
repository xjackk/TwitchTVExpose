// Generated by CoffeeScript 1.12.2
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  define(["entities/_backbone", "msgbus"], function(_Backbone, msgBus) {
    var API, Button, ButtonsCollection;
    Button = (function(superClass) {
      extend(Button, superClass);

      function Button() {
        return Button.__super__.constructor.apply(this, arguments);
      }

      Button.prototype.defaults = {
        buttonType: "button"
      };

      return Button;

    })(_Backbone.Model);
    ButtonsCollection = (function(superClass) {
      extend(ButtonsCollection, superClass);

      function ButtonsCollection() {
        return ButtonsCollection.__super__.constructor.apply(this, arguments);
      }

      ButtonsCollection.prototype.model = Button;

      return ButtonsCollection;

    })(_Backbone.Collection);
    API = {
      getFormButtons: function(buttons, model) {
        var array, buttonCollection;
        buttons = this.getDefaultButtons(buttons, model);
        array = [];
        if (buttons.cancel !== false) {
          array.push({
            type: "cancel",
            className: "btn btn-warning btn-small",
            text: buttons.cancel
          });
        }
        if (buttons.primary !== false) {
          array.push({
            type: "primary",
            className: "btn btn-success btn-small",
            text: buttons.primary,
            buttonType: "submit"
          });
        }
        if (buttons.placement === "left") {
          array.reverse();
        }
        buttonCollection = new ButtonsCollection(array);
        buttonCollection.placement = buttons.placement;
        return buttonCollection;
      },
      getDefaultButtons: function(buttons, model) {
        return _.defaults(buttons, {
          primary: model.isNew() ? "Create" : "Update",
          cancel: "Cancel",
          placement: "right"
        });
      }
    };
    return msgBus.reqres.setHandler("form:button:entities", function(buttons, model) {
      if (buttons == null) {
        buttons = {};
      }
      return API.getFormButtons(buttons, model);
    });
  });

}).call(this);
