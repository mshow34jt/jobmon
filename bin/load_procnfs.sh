#!/bin/bash
for i in `find /data/ldms -name procnfs.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procnfs.pl; 
	mv  $i bak  
	mv  bak/data/ldms/procnfs.HEADER*  2> /dev/null
done



