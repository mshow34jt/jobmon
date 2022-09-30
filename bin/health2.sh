#!/bin/bash
ports='15100 15101 15102 15200 15201 15202 15300 15301 15302'

for i in $ports
do
        echo "$i:"
                        curl http://localhost:$i/healthz
        done
