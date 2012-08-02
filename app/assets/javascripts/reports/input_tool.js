app.reports.InputTool = Base.View.extend({

  el: ".js-input-tool",

  events: {
    'click .js-trash-button': '_trashButtonClicked',
    'click .js-add-button': '_addButtonClicked'
  },

  initialize: function(options) {

  },

  _addButtonClicked: function() {
    prLog('Add button clicked');
  },

  _trashButtonClicked: function() {
    this.$('input').val('');
  }

});