app.reports.Report = Base.Model.extend({

  // items      - Item Models

  defaults: {
    report_type: 'sprint-release',
    title: 'default title',
    subtitle: 'default subtitle'
  },

  urlRoot: '/reports',
  items: null,

  initialize: function(options) {
    this.items = new app.reports.Items();

    if (!options.items) {
      return;
    }

    this.items.add(options.items);
  },

  toJSON: function() {
    var json = {report: this.attributes};
    json.report.items = this.items.toJSON();
    return json;
  }

});

