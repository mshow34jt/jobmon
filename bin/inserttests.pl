#!/usr/bin/perl

use strict;
use warnings;
use POSIX;
use threads;

use DBI;

#my @queryArray;
my $queryHeader="insert ignore into tests (testName,testType,typeId,duration,metric,threshold,calc,grouping) values ";

#my $filename=$ARGV[0];
my $lineCounter=0;
my $valCounter=0;
my $valCount=8;
my $f1;
my $f2;
my $f3;
my $f4;
my $f5;
my $f6;
my $f7;
my $f8;
my $dsn= "DBI:mysql:ISC:host=127.0.0.1:port=15306";
my $query;	


#open (my $FH, '<', $filename) or die "Can't open '$filename' for read: $!";
while (my $line = <STDIN>) {
    chomp $line;
    $lineCounter++;
#    print "reading line $lineCounter\n";
    
	($f1,$f2,$f3,$f4,$f5,$f6,$f7,$f8) = split(',',$line,$valCount);
	print "Read: f2 $f3 $f4 $f5 $f6 $f7 $f8\n";

	$query="insert into tests (testName,testType,typeId,duration,metric,threshold,calc,grouping) values  ('$f1','$f2','$f3',$f4,'$f5',$f6,'$f7','$f8') ON DUPLICATE KEY UPDATE testType='$f2' , typeId='$f3' , duration=$f4 , metric='$f5' , threshold=$f6 , calc='$f7' , grouping='$f8'";
#	print "query=$query\n";	
	 my $dbcon = DBI->connect($dsn)||
                  print STDERR "FATAL: Could not connect to database.\n$DBI::errstr\n";
                  chomp ( $query );
                 print "$query\n";
                  $dbcon->do($query);
                  $dbcon->disconnect();
}
