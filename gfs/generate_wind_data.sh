#!/bin/bash

# GFS_SCRIPT_PATH
# basebath for scripts

# GFS_JSON_DATA
# target path for gfs json wind-data

DEFAULT_SCRIPT_DIR="~/public_html/scripts/"
DEFAULT_SCRIPT_TARGET="~/public_html/static/data/gfs/"

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

echo "--- wind_data_download start ---";
# log date
date -u

python wind_data_download.py || {
  echo "exit generate_wind_data";
  exit 1;
}

if [ ! -z "${GFS_JSON_DATA}" ]; then

  # split by ":"
  IFS=':' read -ra PATHS <<< "$GFS_JSON_DATA"
  for path in "${PATHS[@]}"; do
    # make sure folder exists
    mkdir -p $path
    echo "copy wind-data to ${path}"
    cp -rfp data $path
  done

else
  # make sure folder exists
  mkdir -p $DEFAULT_SCRIPT_TARGET
  echo "copy wind-data to ${DEFAULT_SCRIPT_TARGET}"
  cp -rfp data $DEFAULT_SCRIPT_TARGET
fi

# cleanup
rm -rf data

echo "--- wind_data_download done ---";
# log date
date -u
