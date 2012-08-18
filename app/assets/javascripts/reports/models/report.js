app.reports.Report = Base.Model.extend({

  // items      - Item Models (backbone collection)

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

    // Remove the raw hash of items. At this point they have been converted
    // to models and stored in a collection.
    this.unset('items');
  },

  toJSON: function() {
    var json = {report: this.attributes};
    json.report.items = this.items.toJSON();
    return json;
  }

});

