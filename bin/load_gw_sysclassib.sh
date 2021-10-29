#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name gw_sysclassib.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_gw_sysclassib.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/gw_sysclassib.HEADER* /data/ldms/bak 2> /dev/null
done



