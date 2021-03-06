#!/bin/bash
#
# This script installs the jameica plattform + hibiscus homebanking
# Andreas Siegemund (ansimun)
#

if [ $EUID -ne 0 ]; then
    echo "Script must be run as root - 'sudo ./install.sh'"
    exit 1
fi

tmpdir=$(mktemp -d -t hibiscus-XXXXX)

jameica_archivename="jameica-linux`uname -m | grep -o '64'`.zip"
jameica_url="https://www.willuhn.de/products/jameica/releases/current/jameica/$jameica_archivename"
jameica_temp_archive="$tmpdir/$jameica_archivename"
hibiscus_url="https://www.willuhn.de/products/hibiscus/releases/current/hibiscus.zip"
hibiscus_temp_archive="$tmpdir/hibiscus.zip"

wget $jameica_url --output-document $jameica_temp_archive
wget $hibiscus_url --output-document $hibiscus_temp_archive

if [ -d /opt/jameica ]; then
    echo "remove /opt/jameica"
    rm -rf /opt/jameica
fi

echo "unzip $jameica_temp_archive to /opt"
unzip -q $jameica_temp_archive -d /opt
echo "unzip $hibiscus_temp_archive to /opt/plugins/hibiscus"
unzip -q $hibiscus_temp_archive -d /opt/jameica/plugins

echo "cleanup $tmpdir"
rm -rf $tmpdir
