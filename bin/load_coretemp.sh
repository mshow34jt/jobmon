#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name "coretemp.1*"`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_coretemp.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/coretemp.HEADER* /data/ldms/bak 2> /dev/null
done



