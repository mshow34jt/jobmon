#!/usr/bin/perl
 
while(1)
 {
           `echo starting >> /data/log/jobmon.out`;
           `uptime >> /data/log/jobmon.out`;
           `/data/ldms/jobmon/bin/checkJobs.pl >> /data/log/jobmon.out`;
           `echo finished >> /data/log/jobmon.out`;
           `uptime >> /data/log/jobmon.out`;
           sleep (120);
 
 }
