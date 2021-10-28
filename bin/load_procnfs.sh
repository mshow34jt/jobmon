#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name procnfs.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procnfs.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/procnfs.HEADER*  2> /dev/null
done



