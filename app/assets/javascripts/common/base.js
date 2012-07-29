app.events = {};
_.extend(app.events, Backbone.Events);

var Base = {
  Model: Backbone.Model,
  Collection: Backbone.Collection,
  View: Backbone.View.extend({

    constructor: function (options) {
      this.bindings = [];
      Backbone.View.apply(this, [options]);
    },

    bindTo: function (model, ev, callback) {
      model.bind(ev, callback, this);
      this.bindings.push({ model: model, ev: ev, callback: callback, context: this });
    },

    unbindFromAll: function () {
      _.each(this.bindings, function (binding) {
          binding.model.unbind(binding.ev, binding.callback, binding.context);
      });
      this.bindings = [];
    },

    dispose: function () {
      if (typeof this.onDispose === "function") {
        this.onDispose();
      }
      this.trigger('dispose', this);
      this.unbindFromAll(); // this will unbind all events that this view has bound to
      this.unbind(); // this will unbind all listeners to events from this view. This is probably not necessary because this view will be garbage collected.
      this.remove(); // uses the default Backbone.View.remove() method which removes this.el from the DOM and removes DOM events.
    }

  })
};