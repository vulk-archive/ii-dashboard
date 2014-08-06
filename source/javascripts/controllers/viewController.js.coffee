@viewController =
  render_view: (template, view_listeners=[], container='page') ->
    template_path = 'views/'+template
    request = $.get(template_path)

    request.done (data) ->
      rendered_html = $.parseHTML(data)
      $("#"+container).html rendered_html

      # Set the url using PushState
      viewController.set_url_string({'view':template})

      # view_listeners is an array of methods that
      # get passed into this function

      # If I need to reload Foundation on this view
      # $(document).foundation()

    request.fail (data) ->
      console.error 'viewController::load_view', data
    request.always (data) ->
      console.log 'viewController::load_view', template_path

  set_url_string: (object) ->
    string = decodeURIComponent($.param(object))
    window.history.pushState({}, '', '?'+string)