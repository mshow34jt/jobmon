#!/usr/bin/perl
 
while(1)
 {
           `echo starting >> /jobmon/log/jobmon.out`;
           `uptime >> /jobmon/log/jobmon.out`;
           `perl /jobmon/bin/checkJobs.pl >> /jobmon/log/jobmon.out`;
           `echo finished >> /jobmon/log/jobmon.out`;
           `uptime >> /jobmon/log/jobmon.out`;
           sleep (120);
 
 }
