#!/bin/bash

uptime >> /data/log/jobmon.out
echo "starting parsers and analysis" >>/data/log/jobmon.out
perl /data/ldms/jobmon/bin/runparsers.pl &
perl /data/ldms/jobmon/bin/runcheck.pl 
