#!/bin/bash

install2.r --error --skipinstalled -r $CRAN -n $NCPUS \
    rvest \
    Rcurl \
    RJSONIO \
    nngeo 



 rm -rf /tmp/downloaded_packages