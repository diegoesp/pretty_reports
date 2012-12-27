app.prettyreports = {

  initialize: function() {

    this.models = {
      importModel: new app.prettyreports.Import()
    };

    this.views = {
      importView: new app.prettyreports.ImportView({ el: $("#import_div"), importModel: this.models.importModel})
    };

    this.controllers = {
    };

    _.each(this.views, function (view) { view.render(); });
  }

}