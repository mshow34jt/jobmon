#!/bin/bash

uptime >> /data/log/jobmon.out
echo "starting parsers and analysis" >>/data/log/jobmon.out
perl /jobmon/bin/runparsers.pl &
perl /jobmon/bin/runcheck.pl 
