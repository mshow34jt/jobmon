#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use DBI;

my $dsn= "DBI:mysql:host=127.0.0.1:port=15306";

my $dbcon = DBI->connect($dsn)||
                        print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";

my $joblist="";
my $query;
my $sth;
my $sth2;
while (my $line = <STDIN>) {

my @job=split(/\|/,$line);

#print Dumper \@job;
if ($job[72] eq "RUNNING")
	{
		$joblist.="'$job[1]',";	
	}
#remove the last comma
}
chop($joblist);
$query="select jobid from ISC.jobs where status='Running' and jobid not in ($joblist)";
#print "Query:$query\n";
$sth=$dbcon->prepare($query);
$sth->execute();
#print "Joblist ($joblist)\n";

 while (my @row = $sth->fetchrow_array) {
   print "$row[0] ";
#      $joblist.=$row[0].",";
	$query="update ISC.jobs set status='Orphan'where jobid=$row[0]";
	#print "$query\n";
	$sth2=$dbcon->prepare($query);
	$sth2->execute();


      }

  print "\n";
 $dbcon->disconnect(); 
