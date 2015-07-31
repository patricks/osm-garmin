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

<<<<<<< HEAD
SVER="426"
MVER="3625"
=======
SVER="421"
MVER="3564"
>>>>>>> bf298d62a2b6d4873abc05a3e491f855af1b040a

CWD=`pwd`

if [ ! -x /usr/bin/curl ]; then
    echo "ERROR: curl not found."
    exit -1
fi

rm -rf splitter*
rm -rf mkgmap*

curl -O http://www.mkgmap.org.uk/download/splitter-r$SVER.tar.gz
tar -xvzf splitter-r$SVER.tar.gz
ln -s splitter-r$SVER/splitter.jar splitter.jar

curl -O http://www.mkgmap.org.uk/download/mkgmap-r$MVER.tar.gz
tar -xvzf mkgmap-r$MVER.tar.gz
ln -s mkgmap-r$MVER/mkgmap.jar mkgmap.jar
