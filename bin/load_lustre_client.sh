#!/bin/bash
for i in `find /data/ldms -maxdepth 1 -type f -name lustre_client.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_lustre_client.pl; 
	mv  $i /data/ldms/bak  
	mv  /data/ldms/lustre_client.HEADER*  /data/ldms/bak 2> /dev/null
done



