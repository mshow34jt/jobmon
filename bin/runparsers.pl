#!/usr/bin/perl
 
while(1)
 {
           `echo starting parsers >> /jobmon/log/jobmon.out`;
           `uptime >> /jobmon/log/jobmon.out`;
           `/jobmon/bin/load_slurm.sh`;	   
           `/jobmon/bin/load_meminfo.sh`;	   
#           `/jobmon/bin/load_procstat_72.sh`;	   
#           `/jobmon/bin/load_procnfs.sh`;	   
#           `/jobmon/bin/load_opa2.sh`;	   
           sleep (60);
 
 }
