app.reports.SprintReleaseController = function(options) {

  this.view = options.view;     // Main view
  this.report = options.report; // Report Model

  this.initialize = function() {
    app.events.on('report:save', this._saveReport, this);
    app.events.on('report:download', this._downloadReport, this);
    app.events.on('report:import', this._importStories, this);
  };

  // Save the report. If a callback is passed as parameter then attach
  // that callback to the model save method.
  this._saveReport = function(reportModel, successCallback) {
    var options = {};
    var that = this;
    if (successCallback) {
      options.success = function(){
        successCallback.apply(that);
      }
    }
    this.report.save(null, options);
  };

  this._downloadReport = function() {
    this._saveReport(this.report, this._processDownload);
  };

  // Put the downloader to run
  this._processDownload = function() {
    window.location.href = this.report.url() + '.pdf';
  };

  this._importStories = function() {

    wizard = function() {
      // TODO: Replace with http://www.webdesignerdepot.com/2012/10/creating-a-modal-window-with-html5-and-css3/ ?
      window.location.href = "/import_pivotal_wizard/new?report_id=" + this.report.id;
    };

    this._saveReport(null, wizard);
  };

  // --
  this.initialize(options);
};