#!/bin/bash
for i in $( cat /ingenica_scripts/users.txt ); do
    useradd $i
    echo $i:$i"210521" | chpasswd
    mkdir -p /home/${i}
    chown ${i}:${i} /home/${i}
    addgroup ${i} staff

    mkdir -p /home/${i}/.rstudio/monitored/user-settings
    echo "alwaysSaveHistory='0' \
      \nloadRData='0' \
      \nsaveAction='0'" \
      > /home/${i}/.rstudio/monitored/user-settings/user-settings

    chown -R "${i}:${i}" "/home/${i}"

done
