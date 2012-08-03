// Public: Representation of Sprint Release Report
app.reports.SprintReleaseView = Base.View.extend({

  // items - Reference to the collection of items

  el: '.js-sprint-release-report',

  initialize: function(options) {
    this.items = options.items;
    this.bindTo(this.items, 'add', this._itemAdded);
  },

  _itemAdded: function(model) {
    var section = model.get('section');
    var renderedItem = new app.reports.ItemView({model: model}).render().el;

    if (section === 'delivered') {
      this._addToDelivered(renderedItem);
    } else if (section === 'not-finished') {
      this._addToNotFinished(renderedItem);
    } else if (section === 'known-issue') {
      this._addToKnownIssues(renderedItem);
    }

  },

  _addToDelivered: function(itemView) {
    this.$('.js-delivered').append(itemView);
  },

  _addToNotFinished: function(itemView) {
    this.$('.js-not-finished').append(itemView);
  },

  _addToKnownIssues: function(itemView) {
    this.$('.js-known-issues').append(itemView);
  }

});