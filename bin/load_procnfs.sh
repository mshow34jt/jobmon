#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name procnfs.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_procnfs.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/procnfs.HEADER*  2> /dev/null
done



