#!/bin/bash

echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen \
  && locale-gen es_ES.utf8 \
  && /usr/sbin/update-locale LANG=es_ES.UTF-8 \