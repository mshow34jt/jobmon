#!/bin/bash
for i in `find /data/ldms -name "meminfo.1*"`
do 
	#echo $i
	cd /data/ldms
	cat  $i |/jobmon/bin/parse_meminfo.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/meminfo.HEADER* 	/data/ldms/bak
done



