
# Analyzing fall foliage colors in Connecticut

This repository contains source data and analysis code for the Trend CT story:

*  [When Connecticut's changing leaves will be most brilliant](http://projects.ctmirror.org/content/trend/2016/10/foliage/).

# Foliage data viz

The analysis for this project is available here:

* https://github.com/trendct-data/ct-leaf-colors-analysis

# Walkthroughs

* Analyzing and visualizing fall foliage colors (coming soon)- [HTML] [RMarkdown] 

### The Data

The photos used in this analysis are from the archives of [EarthCam](http://www.earthcam.com/usa/connecticut/) via Connecticut's Department of Energy & Environmental Protection [hazecams](http://www.ct.gov/deep/cwp/view.asp?a=2684&q=404638&depNav_GID=1744).

* The folder of full-sized photos are not included in this repo since each cam yields about 5 GB of photos
* Cropped photos are available, though. Their resolution is about 175 x 131 pixels.
* The photos are from noon
* Some days were not available if the cam was unresponsive or the service was down that day

### What's in this repo

* `_cropped` **folder** - Resized photos of earthcam photos.
* `collages` **folder** - Collages of earthcam photos by year and camera.
* `hex_lists` **folder** - dataframes of cams and dates and the dominant hex color of the leaves.
* `map` **folder** - Various spatial location visualizations.
* `shapes` **folder** - Raw shape files used in the spatial visualizations.
* `spectrums` **folder** - Generated spectrum charts of foliage by camera and year.
* `story` **folder** - Drafts of the story.
* `collage_maker.R` - This script creates an annual collage of earthcam photos by resizing raw photos and placing them on a grid. These large images were originally planned to help simplify the loading of photos in our interactives but even the minified, gridded files were too large to use in the end.
* `gif_maker.R` - Creating a GIF with annotations of individual phase map images.
* `image_analyzer.R` - This script takes raw images in a folder, crops them to where the foliage is, determines the median color for each, and adds it to a dataframe and exports it.
* `image_cropper.R` - This script resizes raw photos for use in our interactives
* `locator-map.R` - Generates locator maps of differing sizes and line/font width for use with our story
* `photo-scraper.R` - This script pulls the noontime daily photos from 3 earthcam archives between 2011 and 2016. 
* `visualizer.R` - This script visualizes the spectrum of colors in a year for a given camera.

----

### Philosophy

We believe in open data. Our scripts may be too technical for the average reader, but we make it accessible because we believe it is important to be as transparent as possible about our methodology so our work can be checked or expanded upon. [Read more](http://www.trendct.org/data).

Check out the reproducible scripts and data behind many of our other stories in our [central repo](https://github.com/trendct-data)

Follow us out on Twitter [@TrendCT](http://www.trendct.org) and on [Facebook/TrendCT](https://www.facebook.com/trendct/).

### Usage

If you use our data or methodology, please give us a shout out in your story. It'd also be nice if you gave me a heads up: [@abtran](http://www.twitter.com/abtran) or abtran@trendct.org.