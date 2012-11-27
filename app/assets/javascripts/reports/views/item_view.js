app.reports.ItemView = Base.View.extend({

  // model    - Item Model
  // removeEl - Jquery wrapped instance of remove element

  tagName: 'li',

  initialize: function(options) {
    this.template = _.template($('#js-item-template').html());
  },

  events: {
    'click': '_clicked',
    'mouseover': '_mouseover',
    'mouseout': '_mouseout',
    'click .js-remove': '_removeClick'
  },

  render: function() {
    // Set the html id to the backbone cid, useful to reference it later on.
    this.$el.attr('id', this.model.cid);

    this.$el.html(this.template(this.model.toJSON()));
    this._postRenderInitialization();
    return this;
  },

  _removeClick: function() {
    app.events.trigger('item:remove', {model: this.model, view: this});
  },

  _mouseout: function() {
    this.removeEl.fadeTo(0, .5);
  },

  _mouseover: function() {
    this.removeEl.fadeTo(0, 1);
  },

  _clicked: function() {
    prLog('>> Pos: ' + this.model.get('position'));
    prLog('>> Cid: ' + this.model.cid);
    prLog('>> Section: ' + this.model.get('section'));
  },

  _postRenderInitialization: function() {
    this.removeEl = this.$('.js-remove');
    this.removeEl.fadeTo(0, .5);
  }

});