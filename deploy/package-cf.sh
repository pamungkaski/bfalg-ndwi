#!/bin/bash

# bfalg-ndwi
# https://github.com/venicegeo/bfalg-ndwi

# Copyright 2016, RadiantBlue Technologies, Inc.

# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# system paths
LIBPATH='/usr/lib/x86_64-linux-gnu'
PYTHONPATH='/usr/local/lib/python2.7/dist-packages'

mkdir -p lib/python2.7
mkdir share

# package libraries
cp -L /usr/local/lib/libgdal.so.20 lib/
cp -LR /usr/local/share/gdal share/gdal
cp -L /usr/lib/libgeos_c.so.1 lib/
cp -L /usr/lib/libgeos-3.4.2.so lib/
cp -L /usr/lib/libproj.so.0 lib/
cp -L /usr/local/lib/libpotrace.so.0 lib/
cp -L $LIBPATH/libpython2.7.so.1.0 lib/

# package app and python libs
pip install ../
# rsync is the best way
rsync -ax $PYTHONPATH ./lib/python2.7/ --exclude-from excluded_packages
#ln -s GDAL-1.11.5-py2.7-linux-x86_64.egg/osgeo lib/python2.7/dist-packages/osgeo
# create link to CLI
ln -s lib/python2.7/dist-packages/bfalg_ndwi/ndwi.py bfalg-ndwi.py

# zip up contents
zip -ruq ../deploy.zip ./ -x excluded_packages package*.sh
