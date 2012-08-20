app.reports.SprintReleaseController = function(options) {

  this.view = options.view;     // Main view
  this.report = options.report; // Report Model
  this.downloader = new app.reports.Downloader(); // Downloader

  this.initialize = function() {
    app.events.on('report:save', this._saveReport, this);
    app.events.on('report:download', this._downloadReport, this);
    this.report.on('change:downloadAvailable', this._downloadAvailable);
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
    reportModel.save(null, options);
  };

  this._downloadReport = function(reportModel) {
    reportModel.set('waitingForDownload', true);
    reportModel.set('downloadAvailable', false);
    this._saveReport(reportModel, this._processDownload);
  };

  // Put the downloader to run
  this._processDownload = function() {
    this.downloader.run(this.report);
  };

  this._downloadAvailable = function(model) {
    if (model.get('downloadAvailable') === true) {
      var url = model.url() + '/download';
      $.ajax({
        dataType: 'json',
        url: url,
        context: this,
        success: function(response) {prLog(response.response);}
      });

    } else {
      prLog('download not available yet');
    }
  };


  // --
  this.initialize(options);
};