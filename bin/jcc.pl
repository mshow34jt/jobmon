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
my $lineNum=0;
my $statusIdx=0;
my $elements=0;

while (my $line = <STDIN>) {

my @job=split(/\|/,$line);

if ($lineNum==0)
        {
		foreach (@job)
		{
			if ($_ eq "State")
			{
				#	print "$elements: $_\n";
				$statusIdx=$elements;
			}
			$elements++;
		}
        }

#print Dumper \@job;
if ($job[$statusIdx] eq "RUNNING")
	{
		$joblist.="'$job[1]',";	
	}
$lineNum++;
#remove the last comma
}
chop($joblist);
$query="select jobid from ISC.jobs where status='Running' and jobid not in ($joblist)";
#print "Query:$query\n";
my $sth=$dbcon->prepare($query);
$sth->execute();
#print "Joblist ($joblist)\n";

 while (my @row = $sth->fetchrow_array) {
   print "$row[0] ";
#      $joblist.=$row[0].",";

      }
  print "\n";
 $dbcon->disconnect(); 
