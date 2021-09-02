#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name opa2.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_opa2.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/opa2.HEADER*  2> /dev/null
done



