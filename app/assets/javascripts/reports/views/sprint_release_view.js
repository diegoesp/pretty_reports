// Public: Representation of Sprint Release Report
app.reports.SprintReleaseView = Base.View.extend({

  // items            - Reference to main collection of items
  // deliveredItems   - Sublist to handle the items that belong to this section
  // notFinishedItems - Sublist to handle the items that belong to this section
  // knownIssuesItems - Sublist to handle the items that belong to this section

  deliveredItems: [],
  notFinishedItems: [],
  knownIssuesItems: [],

  el: '.js-sprint-release-report',

  initialize: function(options) {
    this.items = options.items;
    this.bindTo(this.items, 'add', this._itemAdded);

    var gridsterDefaultOptions = {
      widget_margins: [5, 5],
      widget_base_dimensions: [400, 50]
    };
  },

  _itemAdded: function(itemModel) {
    var section = itemModel.get('section');

    if (section === 'delivered') {
      this._addToDelivered(itemModel);
    } else if (section === 'not-finished') {
      this._addToNotFinished(itemModel);
    } else if (section === 'known-issue') {
      this._addToKnownIssues(itemModel);
    }

  },

  _addToDelivered: function(itemModel) {
    itemModel.set('position', this.deliveredItems.length);
    this.deliveredItems.push(itemModel);

    var renderedItem =
      new app.reports.ItemView({model: itemModel}).render().el;

    this.$('.js-delivered').append(renderedItem);
  },

  _addToNotFinished: function(itemModel) {
    itemModel.set('position', this.notFinishedItems.length);
    this.notFinishedItems.push(itemModel);

    var renderedItem =
      new app.reports.ItemView({model: itemModel}).render().el;

    this.$('.js-not-finished').append(renderedItem);
  },

  _addToKnownIssues: function(itemModel) {
    itemModel.set('position', this.knownIssuesItems.length);
    this.knownIssuesItems.push(itemModel);

    var renderedItem =
      new app.reports.ItemView({model: itemModel}).render().el;

    this.$('.js-known-issues').append(renderedItem);
  }

});