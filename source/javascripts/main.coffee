@main =
  init: () ->
    $(document).foundation
    console.log 'Hi, Welcome to my bootstrap project'
  display:(selector)->
    view = $(selector).data('view')
    viewController.render_view(view)