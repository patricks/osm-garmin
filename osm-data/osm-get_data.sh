#!/bin/sh
###############################################################################
#                                                                             #
# download the daily osm country file from geofabrik.de                       #
#                                                                             #
# @version: 1.10                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 12.11.2010 09:29                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

# read the config from a seperate file
if [ -r ../conf/machine.conf ]; then
    . ../conf/machine.conf
else
    echo "ERROR: No machine config file found."
    exit -1
fi

if [ ! -x /usr/bin/curl ]; then
	echo "ERROR: curl not found."
	exit -1
fi

if [ -z "$1" ]; then
	echo "INFO: No country name given, using default (austria)"
	COUNTRY="austria"
else
	COUNTRY=$1
fi

# downloads the current osm data from the geofabrik server
# remove old data
rm -rf $COUNTRY.osm.pbf

if [ "$COUNTRY" = "germany" ] || [ "$COUNTRY" = "europe" ]; then
	curl -O http://ftp5.gwdg.de/pub/misc/openstreetmap/download.geofabrik.de/$COUNTRY.osm.pbf
else
	curl -O http://download.geofabrik.de/osm/europe/$COUNTRY.osm.pbf
fi
