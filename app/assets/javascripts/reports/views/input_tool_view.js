app.reports.InputToolView = Base.View.extend({

  // items  - Reference to the items collection

  el: ".js-input-tool",

  events: {
    'click .js-trash-button': '_trashButtonClicked',
    'click .js-add-button': '_addButtonClicked'
  },

  initialize: function(options) {
    this.items = options.items;
  },

  _addButtonClicked: function() {
    var itemAttr = {
      title: this.$('[name="title"]').val(),
      subtitle: this.$('[name="subtitle"]').val(),
      section: this.$('[name="section"]').val()
    }

    app.events.trigger('item:create', itemAttr);
  },

  _trashButtonClicked: function() {
    this.$('input').val('');
  }

});