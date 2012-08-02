app.reports = {

  initialize: function(options) {
    prLog('Initializing the app...');

    this.views = {
      inputTool: new app.reports.InputTool()
    }
  }

}