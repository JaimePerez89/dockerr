FROM rocker/rstudio:4.0.5

ENV S6_VERSION=v2.1.0.2
ENV SHINY_SERVER_VERSION=latest
ENV PANDOC_VERSION=default

RUN /rocker_scripts/install_shiny_server.sh

RUN /rocker_scripts/install_tidyverse.sh

RUN /rocker_scripts/install_geospatial.sh

RUN mkdir /ingenica_scripts/

COPY scripts/install_img_video.sh /ingenica_scripts/install_img_video.sh

RUN /ingenica_scripts/install_img_video.sh

COPY scripts/install_img_video.sh /ingenica_scripts/install_ingenicar_dependencies.sh

RUN /ingenica_scripts/install_ingenicar_dependencies.sh

COPY scripts/install_ssh.sh /ingenica_scripts/install_ssh.sh

RUN /ingenica_scripts/install_ssh.sh

COPY scripts/install_ssh.sh /ingenica_scripts/install_ssh.sh

COPY scripts/users.sh /ingenica_scripts/install_ssh.sh

