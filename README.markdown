# Fire Eagle Location Provider for Gears 

This is a modified version of Google's Hello World for Gears that uses a
Sinatra app to convert Fire Eagle responses to geoloc JSON responses in order
that Fire Eagle can be used as a Location Provider.

It was built as an experiment to see how the Location Provider API works.

Relevant modification to hello\_world\_geolocation.html:

    gearsLocationProviderUrls: ["http://localhost:4567"]

Start the Location Provider:

    ./provider.rb
