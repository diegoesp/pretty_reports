// Public: Representation of Sprint Release Report
app.reports.SprintReleaseView = Base.View.extend({

  // items            - Reference to the item models (not a collection)

  // deliveredItems   - Collection of items
  // notFinishedItems - Collection of items
  // knownIssuesItems - Collection of items


  el: '.js-sprint-release-report',

  initialize: function(options) {
    this.items = options.items;

    this.deliveredItems = new app.reports.Items();
    this.notFinishedItems = new app.reports.Items();
    this.knownIssuesItems = new app.reports.Items();

    this.bindTo(this.deliveredItems, 'add', this._deliveredItemAdded);
    this.bindTo(this.notFinishedItems, 'add', this._notFinishedItemAdded);
    this.bindTo(this.knownIssuesItems, 'add', this._knownIssueItemAdded);
    this.bindTo(app.events, 'item:create', this._createItem);
    this.bindTo(app.events, 'item:order:changed', this._updateItemsPosition);


    this.deliveredItems.add(_(this.items).filter(function(item){
      return item.get('section') === 'delivered';
    }));

    this.notFinishedItems.add(_(this.items).filter(function(item){
      return item.get('section') === 'not-finished';
    }));

    this.knownIssuesItems.add(_(this.items).filter(function(item){
      return item.get('section') === 'known-issue';
    }));

    var sortableDefaultOptions = {
      axis: 'y',
      cursor: 'move',
      opacity: '.3',
      update: this._positionChanged
    };

    this.$('.js-delivered').sortable(_(sortableDefaultOptions).extend({
      collection: this.deliveredItems
    }));
    this.$('.js-not-finished').sortable(_(sortableDefaultOptions).extend({
      collection: this.notFinishedItems
    }));
    this.$('.js-known-issues').sortable(_(sortableDefaultOptions).extend({
      collection: this.knownIssuesItems
    }));
  },

  _createItem: function(itemAttr) {
    var itemModel = new app.reports.Item(itemAttr);
    var section = itemModel.get('section');

    switch (section) {
      case 'delivered':
        this.deliveredItems.add(itemModel);
        break;
      case 'not-finished':
        this.notFinishedItems.add(itemModel);
        break;
      case 'known-issue':
        this.knownIssuesItems.add(itemModel);
        break;
    }
  },

  _positionChanged: function(ev, ui) {
    var sortable = $(this);
    var ids = sortable.sortable('toArray');
    var collection = sortable.sortable('option', 'collection');

    _(ids).each(function(id, index){
      var model = collection.getByCid(id);
      model.set('position', index);
    });
  },

  _deliveredItemAdded: function(itemModel) {
    this._addItem(
      this.$('.js-delivered'), this.deliveredItems, itemModel);
  },

  _notFinishedItemAdded: function(itemModel) {
    this._addItem(
      this.$('.js-not-finished'), this.notFinishedItems, itemModel);
  },

  _knownIssueItemAdded: function(itemModel) {
    this._addItem(
      this.$('.js-known-issues'), this.knownIssuesItems, itemModel);
  },

  _addItem: function(el, collection, itemModel) {
    itemModel.set('position', collection.length - 1);
    collection.add(itemModel);
    var renderedItem =
      new app.reports.ItemView({model: itemModel}).render().el;
    el.append(renderedItem);
  }

});