# Build OpenStreetMap maps for Garmin devices

A simple shell script collection to build openstreetmap maps for garmin devices. The maps are optimized for outdoor usage.

## Prebuild Maps
You can download prebuild maps via [osm-garmin-maps](https://github.com/patricks/osm-garmin-maps).

## Installation

* Create a *machine.conf* file in the conf directory (copy and motify the machine.conf.example file).
* Download boundaries with the *osm-get_bounds.sh* script.
* [optional] Get mkgmap and mkgmap splitter jars or build it via the *mkgmap-suite_get.sh* script.

## Usage

For a standard map without anything special simple run:

`./osm-build_map.sh`

For a map with the outdoor style run:

`./osm-build_map.sh -c austria -t outdoor`

For more help run:

`./osm-build_map.sh -h`
