#!/bin/bash

NCPUS=${NCPUS:-1}

set -e
apt-get update -qq && apt-get -y --no-install-recommends install \
    libavfilter-dev \
    libmagick++-dev \
    ffmpeg && \
  rm -rf /var/lib/apt/lists/*

install2.r --error --skipinstalled -r $CRAN -n $NCPUS \
    av \
    magick \
    gganimate


 rm -rf /tmp/downloaded_packages