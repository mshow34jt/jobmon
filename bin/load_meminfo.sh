#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name meminfo.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_meminfo.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/meminfo.HEADER*  2> /dev/null 
done



