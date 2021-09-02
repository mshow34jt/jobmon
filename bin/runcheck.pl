#!/usr/bin/perl
 
while(1)
 {
           `echo starting >> ../log/jobmon.out`;
           `uptime >> ../log/jobmon.out`;
           `./checkJobs.pl >> ../log/jobmon.out`;
           `echo finished >> ../log/jobmon.out`;
           `uptime >> ../log/jobmon.out`;
           sleep (120);
 
 }
