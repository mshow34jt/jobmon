#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name procnetdev.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_procnetdev.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/procnetdev.HEADER*  2> /dev/null
done



