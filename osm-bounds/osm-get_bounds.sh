#!/bin/sh
###############################################################################
#                                                                             #
# download the world bounds file from navmaps.eu                              #
#                                                                             #
# @version: 1.00                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 11.11.2012 11:24                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

if [ ! -x /usr/bin/curl ]; then
	echo "ERROR: curl not found."
	exit -1
fi

curl -O http://www.navmaps.eu/wanmil/bounds_20121019.zip
