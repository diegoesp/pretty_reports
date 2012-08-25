// Public: Representation of Sprint Release Report
app.reports.SprintReleaseView = Base.View.extend({

  // itemsAttrs        - Literal Item attributes. This list is only used
  //                     when viewing a report with existent items.
  // report            - Report Model
  //
  // deliveredListEl   - Reference to the jquery wrapper for the delivered list
  // notFinishedListEl - Reference to the jquery wrapper for the not
  //                     finished list
  // knownIssuesListEl - Reference to the jquery wrapper for the known
  //                     Issues List

  el: '.js-sprint-release-report',

  initialize: function(options) {
    this.report = options.report;
    this.itemsAttrs = options.itemsAttrs;

    this.bindTo(app.events, 'item:create', this._createAndRenderItem);
    this.bindTo(app.events, 'item:remove', this._removeItem);
    this.bindTo(app.events, 'report:save', this._reportSave);

    this._initializeSortableLists();

    _(this.itemsAttrs).each(function(itemAttrs) {
      this._createAndRenderItem(itemAttrs);
    }, this);
  },

  _initializeSortableLists: function() {
    var sortableDefaultOptions = {
      axis: 'y',
      cursor: 'move',
      opacity: '.3',
      update: this._positionChanged,
      that: this
    };

    this.deliveredListEl = this.$('.js-delivered');
    this.deliveredListEl.sortable(sortableDefaultOptions);

    this.notFinishedListEl = this.$('.js-not-finished');
    this.notFinishedListEl.sortable(sortableDefaultOptions);

    this.knownIssuesListEl = this.$('.js-known-issues');
    this.knownIssuesListEl.sortable(sortableDefaultOptions);
  },

  _reportSave: function() {
    this.report.save();
  },

  _createAndRenderItem: function(itemAttr) {
    var itemModel = new app.reports.Item(itemAttr);
    var section = itemModel.get('section');

    this.report.items.add(itemModel);

    switch (section) {
      case 'delivered':
        this._renderItem(this.deliveredListEl, itemModel);
        break;
      case 'not-finished':
        this._renderItem(this.notFinishedListEl, itemModel);
        break;
      case 'known-issue':
        this._renderItem(this.knownIssuesListEl, itemModel);
        break;
    }
  },

  _removeItem: function(params) {
    var itemModel = this.report.items.getByCid(params.model.cid);
    this.report.items.remove(itemModel);
    params.view.dispose();
    this._updatePositionsAfterRemoving();
  },

  _renderItem: function(list, itemModel) {
    var length = list.sortable('toArray').length;
    itemModel.set('position', length);

    var renderedItem =
      new app.reports.ItemView({model: itemModel}).render().el;

    list.append(renderedItem);
  },

  _positionChanged: function(ev, ui) {
    var list = $(this);
    var that = list.sortable('option', 'that');
    var ids = list.sortable('toArray');
    var collection = that.report.items;

    _(ids).each(function(id, index){

      var model = collection.getByCid(id);
      model.set('position', index);
    });
  },

  _updatePositionsAfterRemoving: function() {
    this._updatePositionsForIds(this.deliveredListEl.sortable('toArray'));
    this._updatePositionsForIds(this.notFinishedListEl.sortable('toArray'));
    this._updatePositionsForIds(this.knownIssuesListEl.sortable('toArray'));
  },

  _updatePositionsForIds: function(ids) {
    _(ids).each(function(id, index){
      var model = this.report.items.getByCid(id);
      model.set('position', index);
    }, this);
  }

});