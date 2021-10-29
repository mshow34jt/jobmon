#!/usr/bin/perl
 
while(1)
 {
           `echo starting parsers >> /data/log/jobmon.out`;
           `uptime >> /data/log/jobmon.out`;
           `/jobmon/bin/load_slurm.sh`;	   
           `/jobmon/bin/load_meminfo.sh`;	   
           `/jobmon/bin/load_loadavg.sh`;	   
           `/jobmon/bin/load_procstat_72.sh`;	   
           `/jobmon/bin/load_procnfs.sh`;	   
           `/jobmon/bin/load_opa2.sh`;	   
           `/jobmon/bin/load_lustre_client.sh`;	   
           `/jobmon/bin/load_gw_sysclassib.sh`;	
           sleep (60);
 
 }
