app.prettyreports.ImportView = Base.View.extend({

  initialize: function(options) {
    this.importModel = options.importModel;
    this.importModel.bind("change", this.render);
  },

  events: {
    'keyup': 'api_token_keyup'
  },

  render: function() {    
    // $("#api_token").prop("value", this.importModel.api_token);
  },

  api_token_keyup: function() {
    
    // API token should be 32 characters exactly
    value = $("#api_token").prop("value");

    $("#api_token_span").prop("innerText", "");

    if (value.length != 0)
    {
      if (value.length != 32)
      {
        $("#api_token_span").prop("innerText", "Pivotal API token must be exactly 32 characters");
      }
      else
      {
        this.importModel.set({ api_token: value });
        this.importModel.save();
      }
    }

  }

});