app.reports = {

  initialize: function(options) {

    // If the page has been instantiated with an undefined report then
    // create an empty one as well as the items. Basically handle the
    // difference between instantiating the page for editing or creating.
    if (!options.report ) {
      options.report = {};
    }
    if (!options.report.items) {
      options.report.items = {};
    }

    $('#js-save-button').on('click', function(event){
      app.events.trigger('report:save');
    });

    var itemsAttrs = _.map(options.report.items, function(itemAttrs){
      return {
        title: itemAttrs.title,
        item_type: itemAttrs.item_type,
        subtitle: itemAttrs.subtitle,
        section: itemAttrs.section
      };
    }, this);

    this.models = {
      report: new app.reports.Report(options.report)
    }

    // All the views on the screen
    this.views = {
      inputTool: new app.reports.InputToolView({
        items: this.items
      }),
      sprintReleaseReport: new app.reports.SprintReleaseView({
        report: this.models.report,
        itemsAttrs: itemsAttrs
      })
    }

    _.each(this.views, function (view) { view.render(); });


  }

}