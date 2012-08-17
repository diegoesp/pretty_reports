app.reports.Report = Base.Model.extend({

  // items      - Items Model

  defaults: {
    report_type: 'sprint-release',
    title: 'default title',
    subtitle: 'default subtitle'
  },

  urlRoot: '/reports',
  items: null,

  initialize: function() {
    this.items = new app.reports.Items();
  },

  toJSON: function() {
    var json = {report: this.attributes};
    json.report.items = this.items.toJSON();
    prLog(json);
    return json;
  }

});

