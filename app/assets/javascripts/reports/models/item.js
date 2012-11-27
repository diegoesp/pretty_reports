app.reports.Item = Base.Model.extend({

  // position   - Position in the list
  // item_type  - Type of item
  // section    - Section which this item belongs

  defaults: {
    item_type: 'feature',
    section: 'delivered'
  }

});

// Items Collection
app.reports.Items = Base.Collection.extend({
  model: app.reports.Item
});
