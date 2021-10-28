#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name opa2.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_opa2.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/opa2.HEADER*  2> /dev/null
done



