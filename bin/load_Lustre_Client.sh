#!/bin/bash
for i in `find /data/ldms -name Lustre_Client.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_Lustre_Client.pl; 
	mv  $i bak  
	mv  bak/data/ldms/Lustre_Client.HEADER*  2> /dev/null
done



