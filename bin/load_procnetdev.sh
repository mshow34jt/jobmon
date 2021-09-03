#!/bin/bash
for i in `find /data/ldms -name procnetdev.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procnetdev.pl; 
	rm $i  
	rm /data/ldms/procnetdev.HEADER*  2> /dev/null
done



