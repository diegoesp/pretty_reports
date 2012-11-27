// Public: Representation of Sprint Release Report
app.reports.SprintReleaseView = Base.View.extend({

  // model             - Report Model

  // deliveredListEl   - Reference to the jquery wrapper for the delivered list
  // notFinishedListEl - Reference to the jquery wrapper for the not
  //                     finished list
  // knownIssuesListEl - Reference to the jquery wrapper for the known
  //                     Issues List

  itemSection: {
    DELIVERED: 'delivered',
    NOT_FINISHED: 'not-finished',
    KNOWN_ISSUE: 'known-issue'
  },

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
      that: this,
      revert: true,
      connectWith: '.js-sortable-report-items',
      dropOnEmpty: true,
      // Ugly hack for the issue of the position offset of the element when
      // dragging it (on webkit browsers).
      helper: function(event, ui){
        var $clone =  $(ui).clone();
        $clone.css('position','absolute');
        return $clone.get(0);
      }
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
      case this.itemSection.DELIVERED:
        this._renderItem(this.deliveredListEl, itemModel);
        break;
      case this.itemSection.NOT_FINISHED:
        this._renderItem(this.notFinishedListEl, itemModel);
        break;
      case this.itemSection.KNOWN_ISSUE:
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

  // Private: This method is called each time a list is updated. When
  // moving an element from one list to another this method will be called
  // twice, since the udpate is happening on two lists.
  //
  _positionChanged: function(ev, ui) {
    var that = $(this).sortable('option', 'that');

    // If there is no sender it means that we need to handle the update for the
    // same list where the drag started. No change of the section is required
    // here.
    if (!ui.sender) {
      that._resetAllModelPositions($(this), that);
    }

    // If there is a sender it means that the element comes from a different
    // list, so we need to update also the section.
    if (ui.sender) {
      var sectionName = that._sectionNameFromList($(this));
      that._resetAllModelPositions($(this), that, sectionName);
    }
  },

  _resetAllModelPositions: function(list, that, sectionName) {
    var listIds = list.sortable('toArray');
    var collection = that.model.items;

    // Update all the positions, easier than calculating the delta.
    _(listIds).each(function(id, index){
      var model = collection.getByCid(id);
      model.set('position', index);
      if (sectionName) {
        model.set('section', sectionName);
      }
    });
  },

  // Private: Return the name of the section for the item depending on
  // the list sent by parameter.
  _sectionNameFromList: function($list) {
    if ($list) {
      if ($list.hasClass('js-delivered')) {
        return this.itemSection.DELIVERED;
      } else if ($list.hasClass('js-not-finished')) {
        return this.itemSection.NOT_FINISHED;
      } else if ($list.hasClass('js-known-issues')) {
        return this.itemSection.KNOWN_ISSUE;
      }
    }
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