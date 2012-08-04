app.reports.ItemView = Base.View.extend({

  // model - Item Model

  initialize: function() {
    this.template = _.template($('#js-item-template').html());
  },

  render: function() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }

});