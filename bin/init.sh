#!/bin/bash

uptime >> /jobmon/log/jobmon.out
echo "starting parsers and analysis" >>jobmon/log/jobmon.out
perl /jobmon/bin/runparsers.pl &
perl /jobmon/bin/runcheck.pl 
