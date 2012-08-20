app.reports.Downloader = function(options) {

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

    $.ajax({
      dataType: 'json',
      url: this.reportModel.url() + '/download-available',
      context: this,
      success: this._success
    });
  };

  this._success = function(response) {
    if (response.code === '101') {
      clearInterval(this.interval);
      this.reportModel.set('downloadAvailable', true);
      this.reportModel.set('waitingForDownload', false);
      this.intents = 0;
    } else if (response.code === '100') {
      prLog('Msg: ' + response.message + ' >> Code: ' + response.code);
      this.intents++;
    }
  };


  // Simple helper to use the setInterval function but using a defined context
  this._setIntervalWithContext = function(code, delay, context) {
    return setInterval(function(){
      code.call(context)
    }, delay);
  };

}