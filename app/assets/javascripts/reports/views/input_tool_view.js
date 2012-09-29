app.reports.InputToolView = Base.View.extend({

  // items  - Reference to the items collection

  el: ".js-input-tool",

  events: {
    'click .js-add-button': '_addButtonClicked'
  },

  initialize: function(options) {
    this.items = options.items;
  },

  _addButtonClicked: function() {
    var itemAttr = {
      title: this.$('[name="title"]').val(),
      subtitle: this.$('[name="subtitle"]').val(),
      section: this.$('[name="section"]').val(),
      item_type: this.$('[name="item-type"]').val()
    }

    app.events.trigger('item:create', itemAttr);
  }

});