#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name "procnet.1*"`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procnet.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/procnet.HEADER* /ldms/ldms/bak 2> /dev/null
done
