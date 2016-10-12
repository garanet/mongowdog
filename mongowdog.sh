#!/bin/bash
# www.garanet.net
# Mongo WatchDog Connections - Script for Cronjob to check if your mongo database has more of 500 connections.
# https://github.com/garanet/mongowdog.git

# SET YOUR VARIABLES
email=;
nproc="500";
date=$(date +"%d/%m/%Y");
time=$(date +"%T");

# Start the job
if [[ $(netstat -an | grep 27017 | wc -l) != ${nproc} ]]; then
    echo "Mongodb running!"
    exit 0;
else
    echo "Mongodb has more of 500 connections"
    service mongodb restart
    wait
    echo "${date} - $time - The mongod server result DOWN" >> /tmp/mongowdog.log
    mail -s "MongoDB Server DOWN - Service restarted" ${email} < /tmp/mongowdog.log
    wait
    exit 1;
fi
