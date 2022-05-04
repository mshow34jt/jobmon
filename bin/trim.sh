#!/bin/bash
for i in gw_sysclassib lnet_stats loadavg lustre_client meminfo opa2 procnet procnfs  procstat_72  

	do	
		#echo $i
		trim=`date -d "1 month ago" +"%s"`
 		mysql -vvv -P 15306 -h 127.0.0.1 ISC -e "delete from \`ISC[-]\`.$i where ctime<$trim limit 4000"
done
