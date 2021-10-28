#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name procnetdev.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procnetdev.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/procnetdev.HEADER*  2> /dev/null
done



