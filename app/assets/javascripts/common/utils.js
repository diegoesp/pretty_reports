// Configure underscore to use {{ }} instead of <% %>.
_.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
};

// Defining a namespace for all the javascript of the application.
window.app = {};


// Custom logger for common console panel (Chrome + Safari + Mozilla.
// Not tested on other browsers, however this method will not fail
// on other borwsers)
app.logger = {

  log: function(msg) {
    that = this;
    if(!window.console) {
      return;
    }
    console.log(msg);
  }

}
// Shortcut
window.prLog = app.logger.log;

// On DOM Ready add behavior to the ajax-loading-indicator.
$(function() {
  $("#ajax-loading-indicator").ajaxStart(function(){
     $(this).show();
  });
  $("#ajax-loading-indicator").ajaxStop(function() {
    $(this).hide()
  });
});

// Initialize the styled selects
$(document).ready(function() {
  jQuery('select.custom-select').styledSelect({innerClass: 'styled-select'})
});
