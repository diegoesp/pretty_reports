app.reports = {

  initialize: function(options) {

    var itemsAttrs = _.map(options.items, function(itemAttrs){
      return {
        title: itemAttrs.title,
        type: itemAttrs.item_type,
        subtitle: itemAttrs.subtitle,
        section: itemAttrs.section
      };
    }, this);


    // All the views on the screen
    this.views = {
      inputTool: new app.reports.InputToolView({
        items: this.items
      }),
      sprintReleaseReport: new app.reports.SprintReleaseView({
        itemsAttrs: itemsAttrs
      })
    }

  _.each(this.views, function (view) { view.render(); });
  }

}