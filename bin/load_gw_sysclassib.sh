#!/bin/bash
for i in `find /data/ldms -name gw_sysclassib.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_gw_sysclassib.pl; 
	mv  $i bak  
	mv  bak/data/ldms/gw_sysclassib.HEADER*  2> /dev/null
done



