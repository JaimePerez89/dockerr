#!/bin/bash

install2.r --error --skipinstalled -r $CRAN -n $NCPUS \
    rvest \
    Rcurl \
    RJSONIO \
    nngeo \
    RPostgreSQL \
    getPass \
    plotly \



 rm -rf /tmp/downloaded_packages