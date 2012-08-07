app.reports.Item = Base.Model.extend({

  defaults: {
    item_type: 'feature',
    section: 'delivered'
  }

});

// Items Collection
app.reports.Items = Base.Collection.extend({
  model: app.reports.Item
});
