#!/bin/bash
for i in `find /data/ldms -name meminfo.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_meminfo.pl; 
	mv  $i bak  
	mv  bak/data/ldms/meminfo.HEADER*  2> /dev/null 
done



