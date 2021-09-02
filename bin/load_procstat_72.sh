#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name procstat_72.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_procstat_72.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/procstat_72.HEADER*  2> /dev/null
done



