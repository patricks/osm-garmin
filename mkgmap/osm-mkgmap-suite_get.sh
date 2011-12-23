#!/bin/sh
###############################################################################
#                                                                             #
# download the latest mkgmap version                                          #
#                                                                             #
# @version: 1.00                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 10.01.2011 10:27                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

if [ ! -x /usr/bin/curl ]; then
    echo "ERROR: curl not found."
    exit -1
fi

CWD=`pwd`

SVER="195"
MVER="2145"

rm -rf splitter*
rm -rf mkgmap*

curl -O http://www.mkgmap.org.uk/splitter/splitter-r$SVER.tar.gz
tar -xvzf splitter-r$SVER.tar.gz
ln -s splitter-r$SVER/splitter.jar splitter.jar

curl -O http://www.mkgmap.org.uk/snapshots/mkgmap-r$MVER.tar.gz
tar -xvzf mkgmap-r$MVER.tar.gz
ln -s mkgmap-r$MVER/mkgmap.jar mkgmap.jar
