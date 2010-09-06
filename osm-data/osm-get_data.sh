#!/bin/sh
###############################################################################
#                                                                             #
# download the daily osm country file from geofabrik.de                       #
#                                                                             #
# @version: 1.00                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 27.07.2010 13:29                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

if [ -z "$1" ]; then
	echo "INFO: No country name given, using default (austria)"
	COUNTRY="austria"
else
	COUNTRY=$1
fi

# remove old data
rm -rf $COUNTRY.osm*

# downloads the current osm data from the geofabrik server
curl -O http://download.geofabrik.de/osm/europe/$COUNTRY.osm.bz2

# extract the data file
bunzip2 $COUNTRY.osm.bz2

