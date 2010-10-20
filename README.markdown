osm-garmin
==========

a simple shell script collection to build openstreetmap maps for garmin devices

Installation
------------

* create a *machine.conf* file in the conf directory (copy and motify the machine.conf.example file)
* [optional] get mkgmap and mkgmap splitter jars or build it via the *mkgmap-suite_get.sh* script

Usage
-----

for a standard map without anything special simple run:

`./osm-build_map.sh`

for a map with the outdoor style run:

`./osm-build_map.sh -c austria -t outdoor`

for more help run:

`./osm-build_map.sh -h`
