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

rm -rf splitter*
rm -rf mkgmap*

curl -O http://www.mkgmap.org.uk/splitter/splitter-r123.tar.gz
tar -xvzf splitter-r123.tar.gz
ln -s splitter-r123/splitter.jar splitter.jar

curl -O http://www.mkgmap.org.uk/snapshots/mkgmap-latest.tar.gz
tar -xvzf mkgmap-latest.tar.gz
ln -s mkgmap-r1773/mkgmap.jar mkgmap.jar
