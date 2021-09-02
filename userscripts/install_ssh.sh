#!/bin/bash

NCPUS=${NCPUS:-1}

set -e
apt-get update -qq && apt-get -y --no-install-recommends install \
    ssh && \
  rm -rf /var/lib/apt/lists/*