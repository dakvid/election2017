This is the code and data for https://david.frigge.nz/election2017/

Comments and questions welcome, by email, GitHub issue or tweet.

The site is created in R, with help from notable packages such as:

* [nzelect](https://github.com/ellisp/nzelect) for data
* [flexdashboard](http://rmarkdown.rstudio.com/flexdashboard/) for website design
* [leaflet](https://rstudio.github.io/leaflet/) and [leaflet.minicharts](https://cran.r-project.org/web/packages/leaflet.minicharts/vignettes/introduction.html) for interactive maps
* [plotly](http://plot.ly/r/) for interactive plots
* [sf](https://github.com/r-spatial/sf) for GIS functionality
* and of course most of the [tidyverse](http://tidyverse.org) for data munging

Various people deserve thanks and credits:

* Peter Ellis deserves explicit thanks for the excellent nzelect package, making the historical data easily accessible.
* The [Electoral Commission](http://www.electionresults.govt.nz) for getting the new results out quickly and accessibly. (And [Catalyst IT](http://www.catalyst.net.nz/news/another-successful-election-supported-catalyst) making it run smoothly in the background.)
* [Chris McDowall inspired](http://hindsight.clerestories.com/2014/01/06/chris-mcdowall-hexagonal-maps/) my interest in hexmaps three years ago ([and others'](https://odileeds.org/blog/2017-05-08-mapping-election-with-hexes)).
* Joseph Wright made [shapefiles of his hexmaps](http://mapdruid.blogspot.co.nz/2015/05/hexagonal-tile-map-of-new-zealand.html) available, which was fantastic. I wouldn't have been able to make that first step myself in the time available, so these were invaluable. And thanks to Stephen Beban for the [pointer to these](https://twitter.com/StephenBeban/status/911779567106277381).
* Bhaskar Karambelkar's [tilegram examples](http://rpubs.com/bhaskarvk/tilegramsR) were my guide for using leaflet. (And I have to figure out how to get NZ data into the [tilegramsR](https://bhaskarvk.github.io/tilegramsR/) package.)
