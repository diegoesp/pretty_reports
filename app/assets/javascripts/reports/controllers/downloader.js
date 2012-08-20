app.reports.Downloader = function(options) {

  this.downloadAvailable = false;
  this.interval = null;
  this.intents = 0;
  this.reportModel = null;

  //
  this.run = function(reportModel) {
    this.reportModel = reportModel;
    this.intents = 0;

    this.interval = this._setIntervalWithContext(function() {
      this._run(reportModel);
    }, 1000, this);

  };

  // Internal implementation
  // This one will run in a loop until the report is generated.
  this._run = function() {

    var baseURL = this.reportModel.url();
    var url = baseURL + '/download-available';

    $.ajax({
      dataType: 'json',
      url: url,
      context: this,
      success: this._success
    });
  };

  this._success = function(response) {
    if (response.downloadAvailable === true) {
      this.downloadAvailable = true;
      clearInterval(this.interval);
      this.reportModel.set('downloadAvailable', true);
      this.reportModel.set('waitingForDownload', false);
      this.intents = 0;
    } else if (response.downloadAvailable === false) {
      prLog('still false');
      this.intents++;
      this.downloadAvailable = false;
    }
  };


  // Simple helper to use the setInterval function but using a defined context
  this._setIntervalWithContext = function(code, delay, context) {
    return setInterval(function(){
      code.call(context)
    }, delay);
  };

}