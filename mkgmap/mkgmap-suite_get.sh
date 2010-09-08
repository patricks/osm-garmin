#!/bin/sh
###############################################################################
#                                                                             #
# download and build the latest mkgmap svn version                            #
#                                                                             #
# @version: 1.00                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 06.09.2010 11:21                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

CWD=`pwd`

svn co http://svn.mkgmap.org.uk/splitter/trunk splitter-svn

svn co http://svn.parabola.me.uk/mkgmap/trunk mkgmap-svn

cd $CWD/splitter-svn
ant

cd $CWD/mkgmap-svn
ant

