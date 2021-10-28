#!/usr/bin/perl
 
while(1)
 {
           `echo starting parsers >> /data/log/jobmon.out`;
           `uptime >> /data/log/jobmon.out`;
           `./load_slurm.sh`;	   
           `./load_meminfo.sh`;	   
           `./load_loadavg.sh`;	   
#           `/jobmon/bin/load_procstat_72.sh`;	   
#           `/jobmon/bin/load_procnfs.sh`;	   
#           `/jobmon/bin/load_opa2.sh`;	   
           sleep (60);
 
 }
