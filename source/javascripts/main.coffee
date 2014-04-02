class Main
  constructor: () ->
    @init()
  init: () ->
    $(document).foundation
    console.log 'Hi, Welcome to my bootstrap project'
window.Main = new Main()
