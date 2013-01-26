app.prettyreports.ImportView = Base.View.extend({

  initialize: function(options) {
    this.importModel = options.importModel;
    this.importModel.bind("change", this.render);
  },

  events: {
    'keyup #api_token': 'api_token_keyup',
    'change #projects': 'projects_change',
    'change #iterations': 'iterations_change',
    'click #import_button': 'import_button_click'
  },

  render: function() {
  },

  api_token_keyup: function() {
    
    api_token = $("#api_token").prop("value");

    // If the API token did not change, do not refresh the screen nor update the server
    if (this.importModel.attributes.api_token == api_token) {
      return;
    }

    this.clean_all_messages();

    // Whenever the user changes the API token all depending data must be refreshed so I have to clean all
    // depending combos
    $("#projects").get(0).options.length = 0;
    $("#projects").attr("disabled", "disabled");
    $("#iterations").get(0).options.length = 0;
    $("#iterations").attr("disabled", "disabled");

    // Save value in the model to compare against future modifications and detect if I have to revalidate the token
    this.importModel.attributes.api_token = api_token;

    if (api_token.length != 0)
    {
      if (api_token.length != 32)
      {
        $("#api_token_span").prop("innerText", "Pivotal API token must be exactly 32 characters");
      }
      else
      {
        var report_id = $.url().param("report_id");

        this.importModel.save({ step: 1, api_token: api_token, report_id: report_id}, {
          success: function(importModel) {
            var projects = importModel.attributes.projects;

            if (projects.length == 0) 
              $("#api_token_span").prop("innerText", "This user appears to not have any projects assigned in Pivotal. Please check your configuration");
            else
            {
              $("#projects").removeAttr("disabled");

              $("#projects").append("<option value=''>(Select a project)</option>");

              for(var i = 0; i < projects.length; i++)
              {
                $("#projects").append("<option value='" + projects[i].id + "'>" + projects[i].name + "</option>");
              }
            }
          },
          error: function(importModel, error) {
            $("#api_token_span").prop("innerText", "Cannot retrieve info from Pivotal. Please check the API token and try again");
          }
        });
      }
    }

  },

  projects_change: function() {

    this.clean_all_messages();
    $("#iterations").get(0).options.length = 0;
    $("#iterations").prop("disabled", "disabled");

    project_id = $("#projects").prop("value");

    if (project_id != "") {
      this.importModel.save({ step: 2, project_id: project_id}, {
        success: function(importModel) {
          var iterations = importModel.attributes.iterations;

          if (iterations.length == 0)
            $("#projects_span").prop("innerText", "It seems this project does not have any iterations available");
          else {
            $("#iterations").removeAttr("disabled");

            $("#iterations").append("<option value=''>(Select an iteration)</option>");

            for (var i = 0; i < iterations.length; i++) {
              $("#iterations").append("<option value='" + iterations[i].id + "'>" + iterations[i].number + "</option>");
            }
          }    
        },
        error: function(importModel, error) {
          $("#projects_span").prop("innerText", "Cannot retrieve iterations for the selected project");
        }
      });
    }
  },

  iterations_change: function() {

    this.clean_all_messages();
    iteration_id = $("#iterations").prop("value");

    if (iteration_id != "") {
      this.importModel.save({ step: 3, iteration_id: iteration_id }, {
        success: function(importModel) {
          stories_count = importModel.attributes.stories.length;

          if (stories_count == 0) {
            $("#iterations_span").prop("innerText", "No stories available to import");
            $("#import_button").prop("disabled", "disabled");
          }
          else {
            $("#iterations_span").prop("innerText", "You will import " + stories_count + " stories into your report");
            $("#import_button").removeAttr("disabled");
          }

        },
        error: function(importModel, error) {
          $("#iterations_span").prop("innerText", "I cannot access the stories for the iteration. Please check your Pivotal configuration");
          $("#import_button").prop("disabled", "disabled");
        }
      });
    }
  },

  import_button_click: function() {

    this.clean_all_messages();
    this.importModel.save({ step: 4 }, {
      success: function(importModel) {
        window.location.href = "/reports/" + importModel.attributes.report_id + "/edit";
      },
      error: function(importModel, error) {
        alert("Could not import stories into the report. Error reported was: " + error);
      }
    });
  },

  clean_all_messages: function() {
    $("#api_token_span").prop("innerText", "");
    $("#iterations_span").prop("innerText", "");
    $("#projects_span").prop("innerText", "");
  }
});