#!/bin/bash

uptime >> /data/log/jobmon.out
echo "starting parsers and analysis" >>/data/log/jobmon.out
perl /jobmon/bin/runparsers.pl >> /data/log/parse.log 2>&1 &
perl /jobmon/bin/runcheck.pl >> /data/log/jobmon.log 2>&1
