FROM rocker/rstudio:4.0.5

ENV S6_VERSION=v2.1.0.2
ENV SHINY_SERVER_VERSION=latest
ENV PANDOC_VERSION=default

RUN /rocker_scripts/install_shiny_server.sh

RUN /rocker_scripts/install_tidyverse.sh

RUN /rocker_scripts/install_geospatial.sh

RUN mkdir /scripts/

COPY userscripts /scripts 

RUN /scripts/install_img_video.sh

RUN /scripts/install_dependencies.sh

RUN /scripts/install_ssh.sh

