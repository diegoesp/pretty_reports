app.reports = {

  initialize: function(options) {

    // If the page has been instantiated with an undefined report then
    // create an empty one. Basically handle the difference between
    // instantiating the page for editing or creating.
    if (!options.report ) {
      options.report = {};
    }

    $('#js-save-button').on('click', function(event){
      app.events.trigger('report:save');
    });

    this.models = {
      report: new app.reports.Report(options.report)
    }

    // All the views on the screen
    this.views = {
      inputTool: new app.reports.InputToolView({
        items: this.items
      }),
      sprintReleaseReport: new app.reports.SprintReleaseView({
        model: this.models.report,
      })
    }

    _.each(this.views, function (view) { view.render(); });

  }

}