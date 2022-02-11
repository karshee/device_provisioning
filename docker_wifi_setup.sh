#!/bin/bash
voxl-wifi station WLAN1-64N9B1 dJF2djNmGR7RQy0r
voxl-configure-docker-support.sh
git clone https://bitbucket.org/arrtec10/mastervoxl_setup.git
cd mastervoxl_setup
git clone https://bitbucket.org/arrtec10/mission_logic.git
cd mission_logic
docker build -t mastervoxl .
cd ../kinesis
docker build -t kinesis .