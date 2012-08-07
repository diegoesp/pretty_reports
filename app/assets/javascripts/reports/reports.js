app.reports = {

  initialize: function(options) {

    $('#js-save-button').on('click', function(event){
      app.events.trigger('report:save');
    });

    var itemsAttrs = _.map(options.items, function(itemAttrs){
      return {
        title: itemAttrs.title,
        type: itemAttrs.item_type,
        subtitle: itemAttrs.subtitle,
        section: itemAttrs.section
      };
    }, this);

    this.models = {
      report: new app.reports.Report()
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