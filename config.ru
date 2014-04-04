require "rubygems"

require "rack"
require "middleman/rack"
require "rack/contrib/try_static"

# Build the static site when the app boots
`bundle exec middleman build`

# Enable Authentication
use Rack::Auth::Basic, "Protected Area" do |username, password|
  username == 'user' && password == 'pass'
end

# Enable proper HEAD responses
use Rack::Head

# Attempt to serve static HTML files
use Rack::TryStatic,
    :root => "tmp",
    :urls => %w[/],
    :try => ['.html', 'index.html', '/index.html']

# Serve a 404 page if all else fails
run lambda { |env|
  [
    404,
    {
      "Content-Type"  => "text/html",
      "Cache-Control" => "public, max-age=60"
    },
    # File.open("tmp/404.html", File::RDONLY)
    File.open("tmp/404/index.html", File::RDONLY)
  ]
}
# Run your own Rack app here or use this one to serve 404 messages:
# run lambda{ |env|
#   not_found_page = File.expand_path("/404.html", __FILE__)
#   if File.exist?(not_found_page)
#     [ 404, { 'Content-Type'  => 'text/html'}, [File.open("/404.html", File::RDONLY)] ]
#   else
#     [ 404, { 'Content-Type'  => 'text/html' }, [File.open("/404.html", File::RDONLY)] ]
#   end
# }