#!/bin/bash

install2.r --error --skipinstalled -r $CRAN -n $NCPUS \
    ncdf4.helpers \
    ncdf4 \
    rWind \
    rvest \
    Rcurl \
    RJSONIO \
    nngeo 



 rm -rf /tmp/downloaded_packages