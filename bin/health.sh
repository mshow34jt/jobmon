#!/bin/bash
ports='15100 15101 15102 15110 15111 15112 15120 15121 15122 15130 15131 15132 15140 15141 15142 15150 15151 15152 15160 15161 15162 15170 15171 15172 15180 15181 15182 15190 15191 15192 15200 15201 15202 15210 15211 15212 15220 15221 15222 15230 15231 15232 15240 15241 15242 15250 15251 15252 15300 15301 15302'

for i in $ports
do
        echo "$i:"
		        curl http://mon1.sandia.gov:$i/healthz
	done
