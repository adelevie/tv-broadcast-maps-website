# TV Broadcast Maps Website

This library builds a simple website of US TV Broadcast maps, organized by state.

Just fork this repo, and copy the contents of the `www` directory and drop into any web server.

All contour data originated at the [FCC's Stations API](https://stations.fcc.gov/developer/), which I have converted to GeoJSON and stored [here](https://github.com/adelevie/tv-broadcast-maps).

## Dependencies

To view/serve the HTML files, there are no dependencies that you need to install. However, the static pages rely on a CDN-backed copy of [Leaflet.js](http://leafletjs.com/).

You can also very easily build these maps from source. You just need Ruby installed on a Mac or Linux computer:

```sh
$ git clone https://github.com/adelevie/tv-broadcast-maps-website.git
$ cd tv-broadcast-maps-website
$ bundle
$ sh bootstrap.sh
```

If you have `node` installed, you can also run a simple development server (this avoids some potential browser origin issues):

```sh
$ node install connect
$ node dev-server.js
```

From here, go to `localhost:1337/www/index.html` in a browser.

## Developing

If you want to edit the pages, just change the appropriate file in the `templates` folder, and run:

```sh
$ ruby render.rb
```

You can also run:

```sh
$ rescue render.rb
```

This uses the `pry-rescue` gem, which can be helpful for debugging.


### TODO

- Edit contour markers (make them smaller or just make them go away).
- Add very thin opacity to contour layers, so areas that have access to multiple stations are darker.

# License

Except where any data or software is in the public domain, this library is licensed under the MIT License. See `LICENSE`.