#!/bin/bash
for i in `find /scratch_A/ncsa/eclipse/store_function_csv/spool -name Lustre_Client.1*`
do 
	#echo $i
	cat  $i |/ascldap/users/mtshowe/vitess/parsers/parse_Lustre_Client.pl; 
	rm $i  
	rm /scratch_A/ncsa/eclipse/store_function_csv/spool/Lustre_Client.HEADER*  2> /dev/null
done



