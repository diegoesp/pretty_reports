app.reports.SprintReleaseController = function(options) {

  this.view = options.view;     // Main view
  this.report = options.report; // Report Model
  this.downloader = new app.reports.Downloader(); // Downloader

  this.initialize = function() {
    app.events.on('report:save', this._saveReport, this);
    app.events.on('report:download', this._downloadReport, this);
    this.report.on('change:downloadAvailable', this._downloadAvailable, this);
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
    this.report.set('waitingForDownload', true);
    this.report.set('downloadAvailable', false);
    this._saveReport(this.report, this._processDownload);
  };

  // Put the downloader to run
  this._processDownload = function() {
    $.ajax({
      url: this.report.url() + '/download-available',
      context: this,
      success: function(response) {
        if (response.code === '100') {
          this.downloader.run(this.report);
        } else if (response.code === '101') {
          this.report.set('downloadAvailable', true);
          this.report.set('waitingForDownload', false);
        }
      }
    });
  };

  this._downloadAvailable = function(model) {
    if (model.get('downloadAvailable') === true) {
      this._downloadFile();
    } else {
      prLog('download not available yet');
    }
  };

  this._downloadFile = function() {
    prLog('downloading file');
    window.location.href = this.report.url() + '/download';
  };

  // --
  this.initialize(options);
};