= geo-spider

* http://geospider.rubyforge.org
* http://github.com/tomtaylor/geo-spider

== DESCRIPTION:

Tool for spidering websites/blogs, extracting geodata from specific pages.

Starting at a base URL, it will spider every page underneath, returning pages which have a URL that matches a desired pattern.

The typical use case is spidering an entire blog for posts which contain geodata.

Different methods for extracting geodata can be used. It currently supports UK postcodes and the abbr design pattern geo microformat <http://microformats.org/wiki/geo>.

It is current in use behind the scenes of the Geoblogomatic <http://www.geoblogomatic.com>

== FEATURES/PROBLEMS:

* Still very much in development.

== SYNOPSIS:

Spider entire sites like so:

  require 'geo-spider'
  site = GeoSpider::Site.new("http://www.piecesofhackney.co.uk")
  
  site.each_page do |page|
    puts page.locations.inspect
  end
  
Extract geodata from specific page like so:

  require 'geo-spider'
  page = GeoSpider::Page.new("http://www.nothingtoseehere.net/2008/07/t34_tank_london_1.html")
  puts page.locations.inspect

== REQUIREMENTS:

* hpricot (http://code.whytheluckystiff.net/hpricot/) - for HTML parsing
* graticule (http://graticule.rubyforge.org/) - for geocoding

== LICENSE:

(The MIT License)

Copyright (c) 2008 Tom Taylor

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.