#!/bin/bash

# GFS_SCRIPT_PATH
# basebath for scripts

# GFS_JSON_DATA
# target path for gfs json wind-data

DEFAULT_SCRIPT_DIR="~/public_html/scripts/"

if [ ! -z "${GFS_SCRIPT_PATH}" ]; then
  cd $GFS_SCRIPT_PATH
else
  cd $DEFAULT_SCRIPT_DIR
fi

cd gfs/script
rm -rf data
mkdir data
mkdir data/10
mkdir data/30
mkdir data/100
mkdir data/250
mkdir data/500
mkdir data/850
mkdir data/1000

python wind_data_download.py || { echo 'exit';exit 1; }
rm -rf ../data

if [ ! -z "${GFS_JSON_DATA}" ]; then
  # make sure folder exists
  mkdir -p $GFS_JSON_DATA
  mv -f data $GFS_JSON_DATA
else
  # make sure folder exists
  mkdir -p ~/public_html/static/data/gfs/
  mv -f data ~/public_html/static/data/gfs/
fi
