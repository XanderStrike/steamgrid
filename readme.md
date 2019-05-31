#steamgrid

This is a simple rack application for generating a pretty grid of game banners when given a steam ID.

Check it out at [steamgrid.herokuapp.com](http://steamgrid.herokuapp.com).

### installation

Docker:

    docker run -p 4567:4567 xanderstrike/steamgrid

Local:

    git clone git@github.com:XanderStrike/steamgrid.git
    cd steamgrid
    bundle install
    ruby server.rb

### usage

Visit the app, enter your steam ID (steamcommunity.com/id/THIS) and the minimum number of hours you want the highlighted games to show. Easy.

### license

MIT
