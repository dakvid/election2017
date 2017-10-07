This is the code and data for http://david.frigge.nz/election2017/

Comments and questions welcome, by email or GitHub issues.

The site is created in R, with help from notable packages such as:

* [nzelect](https://github.com/ellisp/nzelect) for data
* [flexdashboard](http://rmrkdown.rstudio.com/flexdashboard) for website design
* [leaflet](http://leaflet.rstudo.org) and [leaflet.minicharts]() for interactive maps
* [plotly](http://plotly.com/r/) for interactive plots
* [sf]() for GIS functionality
* and of course most of the [tidyverse](http://tidyverse.org) for data munging

Various people deserve thanks and credits:

* Peter Ellis deserves explicit thanks for the excellent nzelect package, making the historical data easily accessible.
* The [Electoral Commission](http://www.electionresults.govt.nz) for getting the new results out quickly and accessibly. (And [Catalyst IT]() making it run smoothly in the background.)
* [Chris MacDowall inspired](http://hindsight.clerestories.com/2014/01/06/chris-mcdowall-hexagonal-maps/) my interest in hexmaps three years ago ([and others']()).
* Joseph Wright made [shapefiles of his hexmaps](http://mapdruid.blogspot.co.nz/2015/05/hexagonal-tile-map-of-new-zealand.html) available, which was fantastic. I wouldn't have been able to make that first step myself in the time available, so these were invaluable. And thanks to Stephen Beban for the [pointer to these]().
* Thingamy Bingamy's [tilegram examples]() were my guide for using leaflet. (And I have to figure out how to get NZ data into the [tilegramR]() package.)
