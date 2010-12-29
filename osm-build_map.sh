#!/bin/sh
###############################################################################
#                                                                             #
# builds an osm map for garmin devices                                        #
#                                                                             #
# @version: 1.30                                                              #
# @author: Steiner Patrick <patrick@helmsdeep.at>                             #
# @date: 29.12.2010 12:07                                                     #
# License: GPL                                                                #
# http://www.fsf.org/licenses/gpl.htmlfree for all                            #
#                                                                             #
###############################################################################

#usage example:  ./osm-build_map.sh -c austria -t outdoor

# current date
CDATE=`date "+%G%m%d"`

# strings for the config files
PRETTYDATE=`date "+%d.%m.%G"`

CWD=`pwd`

# check for core applications
function check_apps()
{
	# java
	if [ ! -x /usr/bin/java ]; then
		echo "ERROR: java not found."
		exit -1
	fi

	# sed
	if [ ! -x /usr/bin/sed ]; then
		echo "ERROR: sed not found."
		exit -1
	fi

	# mkgmap splitter
	if [ ! -f $SPLITTERBIN ]; then
		echo "ERROR: mkgmap splitter not found."
		exit -1
	fi

	# mkgmap
	if [ ! -f $MKGMAPBIN ]; then
		echo "ERROR: mkgmap not found."
		exit -1
	fi
}

# build core directories
function build_directories()
{
	# std map std dirs
	if [ ! -d $STDMAPDIR ]; then
		mkdir $STDMAPDIR
	fi

	if [ ! -d $STDMAPDIR/dist ]; then
		mkdir $STDMAPDIR/dist
	fi

	if [ ! -d $STDMAPDIR/build ]; then
		mkdir $STDMAPDIR/build
	fi

	if [ ! -d $OSMDATACACHE ]; then
		mkdir $OSMDATACACHE
	fi

	if [ ! -d $OSMDATATMP ]; then
		mkdir $OSMDATATMP
	fi
}

# build tmp config files
function build_cfg_files()
{
	cd $STDMAPDIR

	if [ ! -f options.args ]; then
		echo "INFO: options.args not found"
		exit -1
	fi

	# generate a random number if we build different countries
	PRETTYCOUNTRY=`echo $COUNTRY | tr [a-z] [A-Z]`

	# create a random number between 20 and 40
	PRETTYNUMBER=`echo $((RANDOM%20+40))`

	# sed -i is not available in all sed versions
	sed "s|PDATE|$PRETTYDATE|g" options.args > options.args.tmp
	sed "s|PCOUNTRY|$PRETTYCOUNTRY|g" options.args.tmp > options.args.tmp1
	sed "s|PNUMBER|$PRETTYNUMBER|g" options.args.tmp1 > options.args.$COUNTRY
	rm -f options.args.tmp
	rm -f options.args.tmp1
}

# split osm data
function split_map()
{
	echo "Spliting map ("$OSMDATA")..."
	cd $OSMDATATMP
	rm -rf *.gz *.list *.args
	java -Xmx${UMEM}M -jar $SPLITTERBIN --max-nodes=1000000 --cache=$OSMDATACACHE $OSMDATA
}

# build garmin img files
function build_map()
{
	echo "Building map..."
	rm -f $STDMAPDIR/build/*.img
	rm -f $STDMAPDIR/build/*.tdb
	cd $STDMAPDIR/build

	# check if TYP file exists
	if [ -f ../styles/$MAPTYPE.TYP ]; then
		TYPFILE="../styles/$MAPTYPE.TYP"
	else
		echo "INFO: TYP file not found"
		TYPFILE=""
	fi

	# check if options file is available
	if [ -f ../options.args.$COUNTRY ]; then
		echo "INFO: Using options.args.$COUNTRY"
		java -Xmx${UMEM}M -jar $MKGMAPBIN --max-jobs -c ../options.args.$COUNTRY $OSMDATATMP/*.osm.gz $TYPFILE
	else
		echo "INFO: options.args.$COUNTRY not found"
		java -Xmx${UMEM}M -jar $MKGMAPBIN --max-jobs --gmapsupp $OSMDATATMP/*.osm.gz $TYPFILE
	fi
}

# build a single garmin img file for the device
function build_device_file()
{
	echo "Building device file..."
	cd $STDMAPDIR/build

	if [ ! -d $STDMAPDIR/dist/$CDATE ]; then
		mkdir $STDMAPDIR/dist/$CDATE
	fi

	if [ ! -d $STDMAPDIR/dist/$CDATE/$MAPTYPE ]; then
		mkdir $STDMAPDIR/dist/$CDATE/$MAPTYPE
	fi

	cp gmapsupp.img $STDMAPDIR/dist/$CDATE/$MAPTYPE/gmapsupp_$COUNTRY.img
}

# scp garmin img to another server
function scp_device_file()
{
	# check if scp is available
	if [ ! -x /usr/bin/scp ]; then
		echo "ERROR: scp not found."
		exit -1
	fi
	scp -r $STDMAPDIR/dist/$CDATE/ $REMOTEUSER@$REMOTEHOST:$REMOTEDIR
}

# updates osm data
function update_osm_data()
{
	echo "Updating OpenStreetMap data"
	cd $OSMDATADIR
	`$OSMDATASCRIPT $1`
}

function usage()
{
	cat << EOF
usage: $0 options

OPTIONS:
	-c <country>	Define the country
	-d		Download osm data
	-t <map type>	Select the map type
	-u		Upload files to another server
	-h		Show this message

EOF
}

###############################################################################
# MAIN                                                                        #
###############################################################################

while getopts ht:duc: OPTION
do
	case $OPTION in
	c)
		COUNTRY=$OPTARG
		;;
	d)
		DLData="YES"
		;;
	t)
		MAPTYPE=$OPTARG
		;;
	u)
		UPLOAD="YES"
		;;
	h)
		usage
		exit 0
		;;
	\?)
		usage >&2
		exit 1
		;;
	esac
done

# read the config from a seperate file
if [ -r conf/machine.conf ]; then
	. conf/machine.conf
else
	echo "ERROR: No machine config file found."
	exit -1
fi

# osm data directory
OSMDATADIR="$OSMGARMINDIR/osm-data"

# osm data download script
OSMDATASCRIPT="$OSMDATADIR/osm-get_data.sh"

# tmp build patch
OSMDATATMP="$OSMGARMINDIR/osm-data-tmp"

# cache directory
OSMDATACACHE="$OSMGARMINDIR/osm-data-cache"

if [ -z "$COUNTRY" ]; then
	echo "Using default country (austria)"
	COUNTRY="austria"
else
	echo "Using country ($COUNTRY)"
fi

if [ -z "$MAPTYPE" ]; then
	echo "Using default map type"
	MAPTYPE="std"
else
	if [ ! -d "osm-map-$MAPTYPE" ]; then
		echo "ERROR: Invalid map type ($MAPTYPE)"
		exit -1
	else
		echo "Using map type ($MAPTYPE)"
	fi
fi

# upload finshed gmap file to server
if [ "$UPLOAD" = "YES" ]; then
	echo "Uploading to server enabled"
fi

# download osm data if it is required
if [ "$DLData" = "YES" ]; then
	update_osm_data $COUNTRY
fi

# osm style type directory
STDMAPDIR="$OSMGARMINDIR/osm-map-$MAPTYPE"

#osm data xml file
if [ "$ENABLEPBF" = "YES" ]; then
	OSMDATA="$OSMDATADIR/$COUNTRY.osm.pbf"
else
	OSMDATA="$OSMDATADIR/$COUNTRY.osm"
fi

if [ ! -f "$OSMDATA" ]; then
	echo "INFO: No OSM Data file ($OSMDATA)found staring download"
	update_osm_data $COUNTRY
fi

echo "Starting build process at: `date`"

build_directories
check_apps
build_cfg_files
#split_map
#build_map
#build_device_file

if [ "$UPLOAD" = "YES" ]; then
	scp_device_file
fi

echo "Build process finished at: `date`"

cd $PWD

# vim:ts=4:sw=4:
