app.reports.ItemView = Base.View.extend({

  // model - Item Model

  tagName: 'li',

  events: {
    'click': '_clicked'
  },

  _clicked: function() {
    prLog('>> Pos: ' + this.model.get('position'));
    prLog('>> Cid: ' + this.model.cid);
  },

  initialize: function() {
    this.template = _.template($('#js-item-template').html());
  },

  render: function() {
    this.$el.attr('id', this.model.cid);
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});