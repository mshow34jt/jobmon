#!/bin/bash
for i in `find /data/ldms -name procstat_72.1*`
do 
	#echo $i
	cat  $i |/jobmon/bin/parse_procstat_72.pl; 
	rm $i  
	rm /data/ldms/procstat_72.HEADER*  2> /dev/null
done



