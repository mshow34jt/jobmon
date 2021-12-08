#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name "procstat_72.1*"`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procstat_72.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/procstat_72.HEADER* /data/ldms/bak 2> /dev/null
done



