app.reports.Item = Base.Model.extend({

  defaults: {
    type: 'feature',
    section: 'delivered'
  }

});

// Items Collection
app.reports.Items = Base.Collection.extend({
  model: app.reports.Item
});
