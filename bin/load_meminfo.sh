#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name "meminfo.1*"`
do 
	#echo $i
	cd /data/ldms
	cat  $i |/jobmon/bin/parse_meminfo.pl; 
	mv  $i /data/ldms/bak  
	if [ -f /data/ldms/meminfo.HEADER* ]
	then
		mv  /data/ldms/meminfo.HEADER* 	/data/ldms/bak
	fi
done



