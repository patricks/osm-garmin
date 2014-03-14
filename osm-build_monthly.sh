#!/bin/sh
###############################################################################
#                                                                             #
# monthly build maps for different  countries                                 #
#                                                                             #
# @version: 1.0.0                                                             #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 14.03.2014 09:05                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

# current date
CDATE=`date "+%G%m%d"`

# strings for the config files
PRETTYDATE=`date "+%d.%m.%G"`

CWD=`pwd`

###############################################################################
# MAIN                                                                        #
###############################################################################

# read the countries from a seperate file
if [ -r conf/countries.conf ]; then
    countries="conf/countries.conf"
else
	echo "ERROR: No countries file found."
	exit -1
fi

while read line
do
    echo "Starting build for country: $line"
    ./osm-build_map.sh -d -c $line -t outdoor
done <"$countries"

# vim:ts=4:sw=4:
