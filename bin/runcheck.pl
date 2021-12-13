#!/usr/bin/perl
 
while(1)
 {
           `echo starting >> /data/log/jobmon.log`;
           `uptime >> /data/log/jobmon.out`;
           `/jobmon/bin/checkJobs.pl >> /data/log/jobmon.log`;
           `echo finished >> /data/log/jobmon.log`;
           `uptime >> /data/log/jobmon.log`;
           sleep (120);
 
 }
