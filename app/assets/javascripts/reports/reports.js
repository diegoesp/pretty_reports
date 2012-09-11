app.reports = {

  scrollAwareEl: null,

  initialize: function(options) {

    // If the page has been instantiated with an undefined report then
    // create an empty one. Basically handle the difference between
    // instantiating the page for editing or creating.
    if (!options.report ) {
      options.report = {};
    }

    this.scrollAwareEl = $('.scroll-aware');

    $('.js-save-button').on('click', function(event){
      app.events.trigger('report:save:clicked');
    });
    $('.js-download-button').on('click', function(event){
      app.events.trigger('report:download:clicked');
    });

    this.models = {
      report: new app.reports.Report(options.report)
    };

    // All the views on the screen
    this.views = {
      inputTool: new app.reports.InputToolView({
        items: this.items
      }),
      sprintReleaseReport: new app.reports.SprintReleaseView({
        model: this.models.report,
      })
    };

    this.controllers = {
      sprintReleaseController:
        new app.reports.SprintReleaseController(
          {
            view: this.views.sprintReleaseReport,
            report: this.models.report
          })
    };

    _.each(this.views, function (view) { view.render(); });

    this._initializeScrollSpy();
  },

  _initializeScrollSpy: function() {
    var that = this;
    $(window).scroll(function(){
      that._mainScrollChanged();
    });
  },

  _mainScrollChanged: function() {
    if ($(window).scrollTop() >= 16) {
      if (!this.scrollAwareEl.hasClass('scrolled-style')) {
        this.scrollAwareEl.addClass('scrolled-style');
      }
    } else {
      if (this.scrollAwareEl.hasClass('scrolled-style')) {
        this.scrollAwareEl.removeClass('scrolled-style');
      }
    }
  }

}