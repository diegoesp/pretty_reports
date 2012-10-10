app.reports.SprintReleaseController = function(options) {

  this.view = options.view;     // Main view
  this.report = options.report; // Report Model

  this.initialize = function() {
    app.events.on('report:save', this._saveReport, this);
    app.events.on('report:download', this._downloadReport, this);
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


  // --
  this.initialize(options);
};