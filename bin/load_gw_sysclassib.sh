#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name gw_sysclassib.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_gw_sysclassib.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/gw_sysclassib.HEADER*  2> /dev/null
done



