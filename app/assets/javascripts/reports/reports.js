app.reports = {

  initialize: function(options) {

    var itemModels = _.map(options.items, function(itemAttrs){
      return new app.reports.Item({
        title: itemAttrs.title,
        type: itemAttrs.item_type,
        subtitle: itemAttrs.subtitle,
        section: itemAttrs.section
      });
    }, this);

    // Colleciton of items
    this.items = new app.reports.Items();

    // All the views on the screen
    this.views = {
      inputTool: new app.reports.InputToolView({
        items: this.items
      }),
      sprintReleaseReport: new app.reports.SprintReleaseView({
        items: this.items
      })
    }

  _.each(this.views, function (view) { view.render(); });

  this.items.add(itemModels);
  }

}