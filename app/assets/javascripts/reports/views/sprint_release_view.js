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

    this.bindTo(app.events, 'item:create', this._createAndRenderItem);
    this.bindTo(app.events, 'item:remove', this._removeItem);

    this.bindTo(app.events, 'report:save:clicked', this._reportSaveRequested);
    this.bindTo(app.events, 'report:download:clicked', this._downloadRequested);
    this.bindTo(this.model, 'change:waitingForDownload',
      this._waitingForDownload);

    this._initializeSortableLists();

    _.each(this.model.items.models, function(itemModel) {
      this._addItem(itemModel);
    }, this);

    this._initializeContentEditableElements();
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

  _initializeContentEditableElements: function() {
    this.$('.js-content-editable').attr('contenteditable', true);
  },

  _reportSaveRequested: function() {
    this._updateModelBeforeSaving();
    app.events.trigger('report:save', this.model);
  },

  _downloadRequested: function() {
    this._updateModelBeforeSaving();
    app.events.trigger('report:download', this.model);
  },

  _updateModelBeforeSaving: function() {
    this.model.set('title', $('.js-title').text());
  },

  _createAndRenderItem: function(itemAttrs) {
    var itemModel = new app.reports.Item(itemAttrs);
    this.model.items.add(itemModel);
    this._addItem(itemModel);
  },

  _addItem: function(itemModel) {
    var section = itemModel.get('section');

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

 _renderItem: function(list, itemModel) {
    var length = list.sortable('toArray').length;
    itemModel.set('position', length);

    var renderedItem =
      new app.reports.ItemView({model: itemModel}).render().el;

    list.append(renderedItem);
  },

  _removeItem: function(params) {
    var itemModel = this.model.items.getByCid(params.model.cid);
    this.model.items.remove(itemModel);
    params.view.dispose();
    this._updatePositionsAfterRemoving();
  },

  _positionChanged: function(ev, ui) {
    var list = $(this);
    var that = list.sortable('option', 'that');
    var ids = list.sortable('toArray');
    var collection = that.model.items;

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
      var model = this.model.items.getByCid(id);
      model.set('position', index);
    }, this);
  },

  _waitingForDownload: function(model) {
    if (model.get('waitingForDownload') === true) {
      $('.js-download-button').addClass('waiting-for-download');
    } else {
      $('.js-download-button').removeClass('waiting-for-download');
    }
  }

});