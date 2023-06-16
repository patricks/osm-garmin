#!/bin/sh
###############################################################################
#                                                                             #
# download the world bounds and sea file                                      #
#                                                                             #
# @version: 1.00                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 11.11.2012 11:24                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

CWD=`pwd`

if [ ! -x /usr/bin/curl ]; then
	echo "ERROR: curl not found."
	exit -1
fi

# bounds
rm -rf bounds && mkdir bounds

cd bounds/

curl -O https://www.thkukuk.de/osm/data/bounds-latest.zip

unzip bounds.zip

# sea
cd $CWD

rm -rf sea && mkdir sea

cd sea/

curl -O https://www.thkukuk.de/osm/data/sea-latest.zip

unzip sea.zip

cd $CWD
