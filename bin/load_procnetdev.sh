#!/bin/bash
for i in `find /data/ldms -name procnetdev.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procnetdev.pl; 
	mv  $i bak  
	mv  bak/data/ldms/procnetdev.HEADER*  2> /dev/null
done



