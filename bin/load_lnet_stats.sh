#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name "lnet_stats.1*"`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_lnet_stats.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/lnet_stats.HEADER* /data/ldms/bak 2> /dev/null
done
