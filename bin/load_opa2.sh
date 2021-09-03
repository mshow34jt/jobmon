#!/bin/bash
for i in `find /data/ldms -name opa2.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_opa2.pl; 
	mv  $i bak  
	mv  bak/data/ldms/opa2.HEADER*  2> /dev/null
done



